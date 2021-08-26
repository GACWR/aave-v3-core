import { expect } from 'chai';
import { makeSuite, TestEnv } from './helpers/make-suite';
import { ProtocolErrors, RateMode } from '../helpers/types';
import { getStableDebtToken } from '../helpers/contracts-getters';
import { MAX_UINT_AMOUNT, RAY, ZERO_ADDRESS } from '../helpers/constants';
import { parseEther, parseUnits } from 'ethers/lib/utils';
import BigNumber from 'bignumber.js';
import './helpers/utils/math';
import {
  impersonateAccountsHardhat,
  DRE,
  increaseTime,
  evmSnapshot,
  evmRevert,
} from '../helpers/misc-utils';
import {
  SelfdestructTransferFactory,
  SelfdestructTransfer,
  StableDebtTokenFactory,
} from '../types';

makeSuite('Stable debt token tests', (testEnv: TestEnv) => {
  const { CT_CALLER_MUST_BE_POOL } = ProtocolErrors;

  let snap: string;

  before(async () => {
    snap = await evmSnapshot();
  });

  it('Tries to invoke mint not being the Pool', async () => {
    const { deployer, dai, helpersContract } = testEnv;

    const daiStableDebtTokenAddress = (await helpersContract.getReserveTokensAddresses(dai.address))
      .stableDebtTokenAddress;

    const stableDebtContract = await getStableDebtToken(daiStableDebtTokenAddress);

    await expect(
      stableDebtContract.mint(deployer.address, deployer.address, '1', '1')
    ).to.be.revertedWith(CT_CALLER_MUST_BE_POOL);
  });

  it('Tries to invoke burn not being the Pool', async () => {
    const { deployer, dai, helpersContract } = testEnv;

    const daiStableDebtTokenAddress = (await helpersContract.getReserveTokensAddresses(dai.address))
      .stableDebtTokenAddress;

    const stableDebtContract = await getStableDebtToken(daiStableDebtTokenAddress);

    const name = await stableDebtContract.name();

    expect(name).to.be.equal('Aave stable debt bearing DAI');
    await expect(stableDebtContract.burn(deployer.address, '1')).to.be.revertedWith(
      CT_CALLER_MUST_BE_POOL
    );
  });

  it('check getters', async () => {
    const { deployer, pool, weth, dai, helpersContract, users } = testEnv;
    const daiStableDebtTokenAddress = (await helpersContract.getReserveTokensAddresses(dai.address))
      .stableDebtTokenAddress;
    const stableDebtContract = await getStableDebtToken(daiStableDebtTokenAddress);

    expect(await stableDebtContract.UNDERLYING_ASSET_ADDRESS()).to.be.eq(dai.address);
    expect(await stableDebtContract.POOL()).to.be.eq(pool.address);
    expect(await stableDebtContract.getIncentivesController()).to.not.be.eq(ZERO_ADDRESS);

    const totSupplyAndRateBefore = await stableDebtContract.getTotalSupplyAndAvgRate();
    expect(totSupplyAndRateBefore[0].toString()).to.be.eq('0');
    expect(totSupplyAndRateBefore[1].toString()).to.be.eq('0');

    // Need to create some debt to do this good
    await dai.connect(users[0].signer).mint(parseUnits('1000', 18));
    await dai.connect(users[0].signer).approve(pool.address, MAX_UINT_AMOUNT);
    await pool
      .connect(users[0].signer)
      .deposit(dai.address, parseUnits('1000', 18), users[0].address, 0);
    await weth.connect(users[1].signer).mint(parseUnits('10', 18));
    await weth.connect(users[1].signer).approve(pool.address, MAX_UINT_AMOUNT);
    await pool
      .connect(users[1].signer)
      .deposit(weth.address, parseUnits('10', 18), users[1].address, 0);
    await pool
      .connect(users[1].signer)
      .borrow(dai.address, parseUnits('200', 18), RateMode.Stable, 0, users[1].address);

    const totSupplyAndRateAfter = await stableDebtContract.getTotalSupplyAndAvgRate();
    expect(new BigNumber(totSupplyAndRateAfter[0].toString()).gt(new BigNumber(0))).to.be.eq(true);
    expect(new BigNumber(totSupplyAndRateAfter[1].toString()).gt(new BigNumber(0))).to.be.eq(true);
  });

  it('transfer()', async () => {
    const { users, dai, helpersContract } = testEnv;
    const daiStableDebtTokenAddress = (await helpersContract.getReserveTokensAddresses(dai.address))
      .stableDebtTokenAddress;
    const stableDebtContract = await getStableDebtToken(daiStableDebtTokenAddress);

    await expect(
      stableDebtContract.connect(users[0].signer).transfer(users[1].address, 500)
    ).to.be.revertedWith('TRANSFER_NOT_SUPPORTED');
  });

  it('approve()', async () => {
    const { users, dai, helpersContract } = testEnv;
    const daiStableDebtTokenAddress = (await helpersContract.getReserveTokensAddresses(dai.address))
      .stableDebtTokenAddress;
    const stableDebtContract = await getStableDebtToken(daiStableDebtTokenAddress);

    await expect(
      stableDebtContract.connect(users[0].signer).approve(users[1].address, 500)
    ).to.be.revertedWith('APPROVAL_NOT_SUPPORTED');
    await expect(
      stableDebtContract.allowance(users[0].address, users[1].address)
    ).to.be.revertedWith('ALLOWANCE_NOT_SUPPORTED');
  });

  it('increaseAllowance()', async () => {
    const { users, dai, helpersContract } = testEnv;
    const daiStableDebtTokenAddress = (await helpersContract.getReserveTokensAddresses(dai.address))
      .stableDebtTokenAddress;
    const stableDebtContract = await getStableDebtToken(daiStableDebtTokenAddress);

    await expect(
      stableDebtContract.connect(users[0].signer).increaseAllowance(users[1].address, 500)
    ).to.be.revertedWith('ALLOWANCE_NOT_SUPPORTED');
  });

  it('decreaseAllowance()', async () => {
    const { users, dai, helpersContract } = testEnv;
    const daiStableDebtTokenAddress = (await helpersContract.getReserveTokensAddresses(dai.address))
      .stableDebtTokenAddress;
    const stableDebtContract = await getStableDebtToken(daiStableDebtTokenAddress);

    await expect(
      stableDebtContract.connect(users[0].signer).decreaseAllowance(users[1].address, 500)
    ).to.be.revertedWith('ALLOWANCE_NOT_SUPPORTED');
  });

  it('transferFrom()', async () => {
    const { users, dai, helpersContract } = testEnv;
    const daiStableDebtTokenAddress = (await helpersContract.getReserveTokensAddresses(dai.address))
      .stableDebtTokenAddress;
    const stableDebtContract = await getStableDebtToken(daiStableDebtTokenAddress);

    await expect(
      stableDebtContract
        .connect(users[0].signer)
        .transferFrom(users[0].address, users[1].address, 500)
    ).to.be.revertedWith('TRANSFER_NOT_SUPPORTED');
  });

  it('burn() secondTerm >= firstTerm', async () => {
    // To enter the case where secondTerm >= firstTerm, we also need previousSupply <= amount.
    // The easiest way is to use two users, such that for user 2 his stableRate > average stableRate.
    // In practice to enter the case we can perform the following actions
    // user 1 borrow 2 wei at rate = 10**27
    // user 2 borrow 1 wei rate = 10**30
    // progress time by a year, to accrue significant debt.
    // then let user 2 withdraw sufficient funds such that secondTerm (userStableRate * burnAmount) >= averageRate * supply
    // if we do not have user 1 deposit as well, we will have issues getting past previousSupply <= amount, as amount > supply for secondTerm to be > firstTerm.
    await evmRevert(snap);
    const rateGuess1 = new BigNumber(RAY);
    const rateGuess2 = new BigNumber(10).pow(30);
    const amount1 = new BigNumber(2);
    const amount2 = new BigNumber(1);

    const { deployer, pool, dai, helpersContract, users } = testEnv;

    const sdtFactory = new SelfdestructTransferFactory(deployer.signer);
    const sdt = (await sdtFactory.deploy()) as SelfdestructTransfer;
    await sdt.deployed();
    await sdt.destroyAndTransfer(pool.address, { value: parseEther('1') });
    await impersonateAccountsHardhat([pool.address]);
    const poolSigner = await DRE.ethers.getSigner(pool.address);

    const config = await helpersContract.getReserveTokensAddresses(dai.address);
    const stableDebt = StableDebtTokenFactory.connect(
      config.stableDebtTokenAddress,
      deployer.signer
    );

    await DRE.network.provider.send('evm_setAutomine', [false]);
    await stableDebt
      .connect(poolSigner)
      .mint(users[0].address, users[0].address, amount1.toFixed(0), rateGuess1.toFixed(0));

    await stableDebt
      .connect(poolSigner)
      .mint(users[1].address, users[1].address, amount2.toFixed(0), rateGuess2.toFixed(0));
    await DRE.network.provider.send('evm_mine', []);
    await DRE.network.provider.send('evm_setAutomine', [true]);

    await increaseTime(60 * 60 * 24 * 365);
    const totalSupplyAfterTime = new BigNumber(18798191);
    await stableDebt
      .connect(poolSigner)
      .burn(users[1].address, totalSupplyAfterTime.minus(1).toFixed(0));
  });
});
