// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Receiver {
    event FallbackCalled(address caller, uint256 amount, string message);
    event ReceiveCalled(address caller, uint256 amount, string message);
    event FooCalled(address caller, uint256 amount, string message);

    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, "Fallback was called");
    }

    receive() external payable {
        emit ReceiveCalled(msg.sender, msg.value, "Receive was called");
    }

    function foo(string memory _message, uint256 val)
        public
        payable
        returns (uint256)
    {
        emit FooCalled(msg.sender, msg.value, _message);
        return val;
    }
}

contract Caller {
    event CallResponse(bool callSuccess, bytes callResponseData);

    /*
    @dev:
    Here we call a function in Receiver contract without needing the ABI/source
    for receiver using known address & function to call the Receiver contract
    */
    function callFoo(address payable addr) public payable {
        //@dev: sending ether in the tx, specifying gas amount
        (bool callSuccess, bytes memory callResponseData) = addr.call{
            value: msg.value,
            gas: 4200
        }(abi.encodeWithSignature("foo(string,uint256)", "call foo", 123));
        emit CallResponse(callSuccess, callResponseData);
    }

    // @dev: Here we will call a non-existent function in Receiver, triggering fallback()
    function callBar(address addr) public payable {
        (bool callSuccess, bytes memory callResponseData) = addr.call{
            value: msg.value,
            gas: 4200
        }(abi.encodeWithSignature("bar()"));
        emit CallResponse(callSuccess, callResponseData);
    }
}
