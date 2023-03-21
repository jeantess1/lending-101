pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";
import "./IPool.sol";
contract ExerciceSolution is IExerciceSolution 
{
	
	//ERC20 public USDC = address(0x65aFADD39029741B3b8f0756952C74678c9cEC93 );
	//ERC20 public aDAI = address(0xADD98B0342e4094Ec32f3b67Ccfd3242C876ff7a);
	address poolAddress= address(0x7b5C526B7F8dfdff278b4a3e045083FBA4028790);
	address daiAddress = address(0xBa8DCeD3512925e52FE67b1b5329187589072A55);
	address USDCAddress =address(0x65aFADD39029741B3b8f0756952C74678c9cEC93);
	uint milion=1000000*1005000;
	uint milion_fee=1005000*1000900;
	function depositSomeTokens() override external
	{
		// Input variables
		// mainnet DAI
		uint256 amount = 3000 * 1e18;
		uint16 referral = 0;

		// Approve LendingPool contract to move your DAI
		IERC20(daiAddress).approve(poolAddress, amount);

		// Deposit 1000 DAI
		IPool(poolAddress).supply(daiAddress, amount,address(this), referral);
	}

	function withdrawSomeTokens() override external
	{
		IPool(poolAddress).withdraw(daiAddress,200*1e18,msg.sender);
	}

	function borrowSomeTokens() override external
	{

		IPool(poolAddress).borrow(USDCAddress,100*10e6,2,0,address(this));
	}

	function repaySomeTokens() override external{
		// Approve LendingPool contract to move your DAI
		IERC20(USDCAddress).approve(poolAddress, 20*10e6);

		// Deposit 1000 DAI
		IPool(poolAddress).repay(USDCAddress, 20*10e6, 2,address(this));
	}

	function doAFlashLoan() override external{
		bytes memory data="";
		IPool(poolAddress).flashLoanSimple(address(this), USDCAddress, milion, data, 0);
	}
	/*function rendargent(uint amount) external{
		address moi = address(0xCC5b06709D8D55b16F9c54B0EB2b7b2b18070e46);
		IERC20(USDCAddress).approve(moi, amount*10**6);
		IERC20(USDCAddress).transfer(moi, amount*10**6);
	} */

	function repayFlashLoan() override external{
		IERC20(USDCAddress).approve(poolAddress,milion_fee);
		IPool(poolAddress).repay(USDCAddress,milion_fee,2,address(this));
	}	
}


// Retrieve LendingPool address

