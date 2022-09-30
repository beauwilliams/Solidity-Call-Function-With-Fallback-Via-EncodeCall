import chai, { expect } from "chai";
import { ethers, upgrades } from "hardhat";
import { solidity } from "ethereum-waffle";
chai.use(solidity);
import { Signer } from "ethers";
import {
  Caller,
  Receiver,
  Caller__factory,
  Receiver__factory,
} from "../typechain";

describe("Test", function () {
  let owner: any;
  let accounts: Signer[];
  let Caller: Caller;
  let Receiver: Receiver;
  let CallerContractFactory: Caller__factory;
  let ReceiverContractFactory: Receiver__factory;

  before(async () => {
    CallerContractFactory = <Caller__factory>(
      await ethers.getContractFactory("Caller")
    );
    ReceiverContractFactory = <Receiver__factory>(
      await ethers.getContractFactory("Receiver")
    );
    Caller = await CallerContractFactory.deploy();
    Receiver = await ReceiverContractFactory.deploy();
    await Caller.deployed();
    await Receiver.deployed();
    [owner] = await ethers.getSigners();
  });

  describe("Called existing function in ReceiverContract", function () {
    it("Call foo() in Receiver contract)", async function () {
      await expect(Caller.callFoo(Receiver.address)
            ).to.emit(Receiver, 'FooCalled');
    });
  });

  describe("Called non existing function in ReceiverContract", function () {
    it("Call bar() in Receiver contract)", async function () {
      await expect(Caller.callBar(Receiver.address)
            ).to.emit(Receiver, 'FallbackCalled');
    });
  });
});
