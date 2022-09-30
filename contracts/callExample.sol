// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Receiver {
    event FallbackCalled(address caller, uint256 amount, string message);
    event ReceiveCalled(address caller, uint256 amount, string message);

    fallback() external payable {
        emit ReceiveCalled (msg.sender, msg.value, "Fallback was called");
    }

    receive() external payable {
       emit ReceiveCalled (msg.sender, msg.value, "Receive was called");
    }

    function foo(string memory _message, uint256 val) public payable returns (uint256) {
        emit ReceiveCalled (msg.sender, msg.value, _message);
        return val;
    }
}

contract Caller {
    event CallerCallResponse(bool calluccess, bytes callResponseData);

    /*
    @dev:
    Here we call a function in Receiver contract without needing the ABI/source
    for receiver using known address & function to call the Receiver contract
    */
    function testCallFoo(address payable _addr) public payable {
        //@dev: sending ether in the tx, specifying gas amount
        (bool callSuccess, bytes memory callResponseData) = _addr.call{value: msg.value, gas: 5000}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );
        emit CallerCallResponse(callSuccess, callResponseData);
    }

    // @dev: Here we will call a non-existent function in Receiver, triggering fallback()
    function testCallDoesNotExist(address _addr) public {
        (bool callSuccess, bytes memory callResponseData) = _addr.call(
            abi.encodeWithSignature("doesNotExist()")
        );
        emit CallerCallResponse(callSuccess, callResponseData);
    }
}
