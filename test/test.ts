import { ethers } from "hardhat";
import chai, { expect } from "chai";
import { solidity } from "ethereum-waffle";
chai.use(solidity);

import {
  Caller,
  Receiver,
  Caller__factory,
  Receiver__factory,
} from "../typechain";

describe("Test Suite", function () {
  let CallerContract: Caller;
  let ReceiverContract: Receiver;
  let CallerContractFactory: Caller__factory;
  let ReceiverContractFactory: Receiver__factory;

  before(async () => {
    CallerContractFactory = <Caller__factory>(
      await ethers.getContractFactory("Caller")
    );
    ReceiverContractFactory = <Receiver__factory>(
      await ethers.getContractFactory("Receiver")
    );
    CallerContract = await CallerContractFactory.deploy();
    ReceiverContract = await ReceiverContractFactory.deploy();
    await CallerContract.deployed();
    await ReceiverContract.deployed();
  });

  describe("Called existing function in ReceiverContract", function () {
    it("Call foo() in Receiver contract)", async function () {
      await expect(CallerContract.callFoo(ReceiverContract.address)).to.emit(
        ReceiverContract,
        "FooCalled"
      );
    });
  });

  describe("Called non existing function in ReceiverContract", function () {
    it("Call bar() in Receiver contract)", async function () {
      await expect(CallerContract.callBar(ReceiverContract.address)).to.emit(
        ReceiverContract,
        "FallbackCalled"
      );
    });
  });
});
