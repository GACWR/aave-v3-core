// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.6;

/**
 * @title Errors library
 * @author Aave
 * @notice Defines the error messages emitted by the different contracts of the Aave protocol
 * @dev Error messages prefix glossary:
 *  - VL = ValidationLogic
 *  - MATH = Math libraries
 *  - CT = Common errors between tokens (AToken, VariableDebtToken and StableDebtToken)
 *  - AT = AToken
 *  - SDT = StableDebtToken
 *  - VDT = VariableDebtToken
 *  - P = Pool
 *  - PAPR = PoolAddressesProviderRegistry
 *  - PC = PoolConfiguration
 *  - RL = ReserveLogic
 *  - PCM = PoolCollateralManager
 *  - P = Pausable
 */
library Errors {
  //common errors
  error CallerNotPoolAdmin();
  string public constant CALLER_NOT_POOL_ADMIN = '33'; // 'The caller must be the pool admin'
  error InsufficientBorrowAllowance();
  string public constant BORROW_ALLOWANCE_NOT_ENOUGH = '59'; // User borrows on behalf, but allowance are too small

  //contract specific errors
  error VLInvalidAmount();
  string public constant VL_INVALID_AMOUNT = '1'; // 'Amount must be greater than 0'
  error VLNoActiveReserve();
  string public constant VL_NO_ACTIVE_RESERVE = '2'; // 'Action requires an active reserve'
  error VLReserveFrozen();
  string public constant VL_RESERVE_FROZEN = '3'; // 'Action cannot be performed because the reserve is frozen'
  error VLInsufficientLiquidity();
  string public constant VL_CURRENT_AVAILABLE_LIQUIDITY_NOT_ENOUGH = '4'; // 'The current liquidity is not enough'
  error VslInsufficientUserBalance();
  string public constant VL_NOT_ENOUGH_AVAILABLE_USER_BALANCE = '5'; // 'User cannot withdraw more than the available balance'
  error VLBorrowingDisabled();
  string public constant VL_BORROWING_NOT_ENABLED = '7'; // 'Borrowing is not enabled'
  error VLInvalidRateMode();
  string public constant VL_INVALID_INTEREST_RATE_MODE_SELECTED = '8'; // 'Invalid interest rate mode selected'
  error VLZeroCollateralBalance();
  string public constant VL_COLLATERAL_BALANCE_IS_0 = '9'; // 'The collateral balance is 0'
  error VLHealthFactorBelowLiquidation();
  string public constant VL_HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD = '10'; // 'Health factor is lesser than the liquidation threshold'
  error VLCollateralCannotCoverNewBorrow();
  string public constant VL_COLLATERAL_CANNOT_COVER_NEW_BORROW = '11'; // 'There is not enough collateral to cover a new borrow'
  error VLStableBorrowDisabled();
  string public constant VL_STABLE_BORROWING_NOT_ENABLED = '12'; // stable borrowing not enabled
  error VLCollateralSameAsBorrowCurrency();
  string public constant VL_COLLATERAL_SAME_AS_BORROWING_CURRENCY = '13'; // collateral is (mostly) the same currency that is being borrowed
  error VLRequestGreaterThanMaxLoanSize();
  string public constant VL_AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE = '14'; // 'The requested amount is greater than the max loan size in stable rate mode
  error VLNoDebtOfSelectedType();
  string public constant VL_NO_DEBT_OF_SELECTED_TYPE = '15'; // 'for repayment of stable debt, the user needs to have stable debt, otherwise, he needs to have variable debt'
  error VLNoExplicitAmountToRepayOnBehalfOf();
  string public constant VL_NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF = '16'; // 'To repay on behalf of an user an explicit amount to repay is needed'
  error VLNoStableRateLoan();
  string public constant VL_NO_STABLE_RATE_LOAN_IN_RESERVE = '17'; // 'User does not have a stable rate loan in progress on this reserve'
  error VLNoVariableRateLoan();
  string public constant VL_NO_VARIABLE_RATE_LOAN_IN_RESERVE = '18'; // 'User does not have a variable rate loan in progress on this reserve'
  error VLZeroUnderlyingBalance();
  string public constant VL_UNDERLYING_BALANCE_NOT_GREATER_THAN_0 = '19'; // 'The underlying balance needs to be greater than 0'
  error VLDepositIsAlreadyCollateral();
  string public constant VL_DEPOSIT_ALREADY_IN_USE = '20'; // 'User deposit is already being used as collateral'
  error PNotEnoughStableBorrowBalance();
  string public constant P_NOT_ENOUGH_STABLE_BORROW_BALANCE = '21'; // 'User does not have any stable rate loan for this reserve'
  error PInterestRateRebalanceConditionsUnmet();
  string public constant P_INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET = '22'; // 'Interest rate rebalance conditions were not met'
  error PLiquidationCallFailed();
  string public constant P_LIQUIDATION_CALL_FAILED = '23'; // 'Liquidation call failed'
  error PInsufficientBorrowLiquidity();
  string public constant P_NOT_ENOUGH_LIQUIDITY_TO_BORROW = '24'; // 'There is not enough liquidity available to borrow'
  error PInsufficientRequestedAmount();
  string public constant P_REQUESTED_AMOUNT_TOO_SMALL = '25'; // 'The requested amount is too small for a FlashLoan.'
  error PInconsistentProtocolActualBalance();
  string public constant P_INCONSISTENT_PROTOCOL_ACTUAL_BALANCE = '26'; // 'The actual balance of the protocol is inconsistent'
  error PCallerNotPoolConfigurator();
  string public constant P_CALLER_NOT_POOL_CONFIGURATOR = '27'; // 'The caller of the function is not the pool configurator'
  error PIncositentFlashloanParams();
  string public constant P_INCONSISTENT_FLASHLOAN_PARAMS = '28';
  error CTCallerMustBePool();
  string public constant CT_CALLER_MUST_BE_POOL = '29'; // 'The caller of this function must be a pool'
  error CTCannotGiveSelfAllowance();
  string public constant CT_CANNOT_GIVE_ALLOWANCE_TO_HIMSELF = '30'; // 'User cannot give allowance to himself'
  error CTZeroTransferAmount();
  string public constant CT_TRANSFER_AMOUNT_NOT_GT_0 = '31'; // 'Transferred amount needs to be greater than zero'
  error RLReserveInitialized();
  string public constant RL_RESERVE_ALREADY_INITIALIZED = '32'; // 'Reserve has already been initialized'
  error PCReserveLiquidityNotZero();
  string public constant PC_RESERVE_LIQUIDITY_NOT_0 = '34'; // 'The liquidity of the reserve needs to be 0'
  error PCInvalidAtokenPoolAddress(); // FIX COMMENT
  string public constant PC_INVALID_ATOKEN_POOL_ADDRESS = '35'; // 'The liquidity of the reserve needs to be 0'
  error PCInvalidStableDebtTokenPoolAddress(); // FIX COMMENT
  string public constant PC_INVALID_STABLE_DEBT_TOKEN_POOL_ADDRESS = '36'; // 'The liquidity of the reserve needs to be 0'
  error PCInvalidVariableDebtTokenPoolAddress(); // FIX COMMENT
  string public constant PC_INVALID_VARIABLE_DEBT_TOKEN_POOL_ADDRESS = '37'; // 'The liquidity of the reserve needs to be 0'
  error PCInvalidStableDebtTokenUnderlyingAddress(); // FIX COMMENT
  string public constant PC_INVALID_STABLE_DEBT_TOKEN_UNDERLYING_ADDRESS = '38'; // 'The liquidity of the reserve needs to be 0'
  error PCInvalidVariableDebtTokenUnderlyingAddress(); // FIX COMMENT
  string public constant PC_INVALID_VARIABLE_DEBT_TOKEN_UNDERLYING_ADDRESS = '39'; // 'The liquidity of the reserve needs to be 0'
  error PCInvalidAddressesProviderId(); // FIX COMMENT
  string public constant PC_INVALID_ADDRESSES_PROVIDER_ID = '40'; // 'The liquidity of the reserve needs to be 0'
  error PCInvalidConfiguration();
  string public constant PC_INVALID_CONFIGURATION = '75'; // 'Invalid risk parameters for the reserve'
  error PCCallerNotEmergencyAdmin();
  string public constant PC_CALLER_NOT_EMERGENCY_ADMIN = '76'; // 'The caller must be the emergency admin'
  error PAPRProviderNotRegistered();
  string public constant PAPR_PROVIDER_NOT_REGISTERED = '41'; // 'Provider is not registered'
  error PCMHealthFactorBelowThreshold();
  string public constant PCM_HEALTH_FACTOR_NOT_BELOW_THRESHOLD = '42'; // 'Health factor is not below the threshold'
  error PCMCollateralCannotBeLiquidated();
  string public constant PCM_COLLATERAL_CANNOT_BE_LIQUIDATED = '43'; // 'The collateral chosen cannot be liquidated'
  error PCMSpecifiedCurrencyNotBorrowedByUser();
  string public constant PCM_SPECIFIED_CURRENCY_NOT_BORROWED_BY_USER = '44'; // 'User did not borrow the specified currency'
  error PCMNotEnoughLiquidityToLiquidate();
  string public constant PCM_NOT_ENOUGH_LIQUIDITY_TO_LIQUIDATE = '45'; // "There isn't enough liquidity available to liquidate"
  error PCMNoErrors();
  string public constant PCM_NO_ERRORS = '46'; // 'No errors'
  error PInvalidFlashloanMode();
  string public constant P_INVALID_FLASHLOAN_MODE = '47'; //Invalid flashloan mode selected
  error MATHMultiplicationOverflow();
  string public constant MATH_MULTIPLICATION_OVERFLOW = '48';
  error MATHAdditionOverflow();
  string public constant MATH_ADDITION_OVERFLOW = '49';
  error MATHDivisionByZero();
  string public constant MATH_DIVISION_BY_ZERO = '50';
  error RLLiquidityIndexOverflow();
  string public constant RL_LIQUIDITY_INDEX_OVERFLOW = '51'; //  Liquidity index overflows uint128
  error RLVariableBorrowIndexOverflow();
  string public constant RL_VARIABLE_BORROW_INDEX_OVERFLOW = '52'; //  Variable borrow index overflows uint128
  error RLLiquidityRateOverflow();
  string public constant RL_LIQUIDITY_RATE_OVERFLOW = '53'; //  Liquidity rate overflows uint128
  error RLVariableBorrowRateOverflow();
  string public constant RL_VARIABLE_BORROW_RATE_OVERFLOW = '54'; //  Variable borrow rate overflows uint128
  error RLStableBorrowRateOverflow();
  string public constant RL_STABLE_BORROW_RATE_OVERFLOW = '55'; //  Stable borrow rate overflows uint128
  error CTInvalidMintAmount();
  string public constant CT_INVALID_MINT_AMOUNT = '56'; //invalid amount to mint
  error PFailedRepayWithCollateral();
  string public constant P_FAILED_REPAY_WITH_COLLATERAL = '57';
  error CTInvalidBurnAmount();
  string public constant CT_INVALID_BURN_AMOUNT = '58'; //invalid amount to burn
  error PFailedCollateralSwap();
  string public constant P_FAILED_COLLATERAL_SWAP = '60';
  error PInvalidEqualAssetsToSwap();
  string public constant P_INVALID_EQUAL_ASSETS_TO_SWAP = '61';
  error PReentrancyNotAllowed();
  string public constant P_REENTRANCY_NOT_ALLOWED = '62';
  error PCallerMustBeAtoken();
  string public constant P_CALLER_MUST_BE_AN_ATOKEN = '63';
  error PPaused();
  string public constant P_IS_PAUSED = '64'; // Deprecated 'Pool is paused'
  error PNoMoreReservesAllowed();
  string public constant P_NO_MORE_RESERVES_ALLOWED = '65';
  error PInvalidFlashloanExecutorReturn();
  string public constant P_INVALID_FLASH_LOAN_EXECUTOR_RETURN = '66';
  error RCInvalidLTV();
  string public constant RC_INVALID_LTV = '67';
  error RCInvalidLiquidationThreshold();
  string public constant RC_INVALID_LIQ_THRESHOLD = '68';
  error RCInvalidLiqBonus();
  string public constant RC_INVALID_LIQ_BONUS = '69';
  error RCInvalidDecimals();
  string public constant RC_INVALID_DECIMALS = '70';
  error RCInvalidReserveFactor();
  string public constant RC_INVALID_RESERVE_FACTOR = '71';
  error PAPRInvalidAddressesProviderID();
  string public constant PAPR_INVALID_ADDRESSES_PROVIDER_ID = '72';
  error VLInconsistentFlashloanParams();
  string public constant VL_INCONSISTENT_FLASHLOAN_PARAMS = '73';
  error PInconsistentParamsLength();
  string public constant P_INCONSISTENT_PARAMS_LENGTH = '74';
  error ULInconsistentParamsLength();
  string public constant UL_INVALID_INDEX = '77';
  error PNotContract();
  string public constant P_NOT_CONTRACT = '78';
  error SDTStableDebtOverflow();
  string public constant SDT_STABLE_DEBT_OVERFLOW = '79';
  error SDTBurnExceedsBalance();
  string public constant SDT_BURN_EXCEEDS_BALANCE = '80';
  error VLBorrowCapExceeded();
  string public constant VL_BORROW_CAP_EXCEEDED = '81';
  error RCInvalidBorrowCap();
  string public constant RC_INVALID_BORROW_CAP = '82';
  error VLSupplyCapExceeded();
  string public constant VL_SUPPLY_CAP_EXCEEDED = '83';
  error RCInvalidSupplyCap();
  string public constant RC_INVALID_SUPPLY_CAP = '84';
  error PCCallerNotEmergencyOrPoolAdmin();
  string public constant PC_CALLER_NOT_EMERGENCY_OR_POOL_ADMIN = '85';
  error VLReservePaused();
  string public constant VL_RESERVE_PAUSED = '86';
  error PCCallerNotRiskOrPoolAdmin();
  string public constant PC_CALLER_NOT_RISK_OR_POOL_ADMIN = '87';
  error RLAtokenSupplyNotZero();
  string public constant RL_ATOKEN_SUPPLY_NOT_ZERO = '88';
  error RLStableDebtNotZero();
  string public constant RL_STABLE_DEBT_NOT_ZERO = '89';
  error RLVariableDebtSupplyNotZero();
  string public constant RL_VARIABLE_DEBT_SUPPLY_NOT_ZERO = '90';
  error VLLTVValidationFailed();
  string public constant VL_LTV_VALIDATION_FAILED = '93';
  error VLSameBlockBorrowRepay();
  string public constant VL_SAME_BLOCK_BORROW_REPAY = '94';
  error PCFlashloanPremiumsMismatch();
  string public constant PC_FLASHLOAN_PREMIUMS_MISMATCH = '95';
  error PCFlashloanPremiumInvalid();
  string public constant PC_FLASHLOAN_PREMIUM_INVALID = '96';

  enum CollateralManagerErrors {
    NO_ERROR,
    NO_COLLATERAL_AVAILABLE,
    COLLATERAL_CANNOT_BE_LIQUIDATED,
    CURRRENCY_NOT_BORROWED,
    HEALTH_FACTOR_ABOVE_THRESHOLD,
    NOT_ENOUGH_LIQUIDITY,
    NO_ACTIVE_RESERVE,
    HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD,
    INVALID_EQUAL_ASSETS_TO_SWAP,
    FROZEN_RESERVE,
    PAUSED_RESERVE
  }
}
