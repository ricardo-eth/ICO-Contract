/* eslint-disable comma-dangle */
/* eslint-disable no-unused-expressions */
/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */
const { expect } = require('chai');

describe('Cal (CAL) contract', function () {
  const amount = ethers.utils.parseEther('1');

  before(async () => {
    const contract = await ethers.getContractFactory('CAL');
    token = await contract.deploy();
    accounts = await ethers.getSigners();
    await token.deployed();
  });

  it('Assigns initial balance', async function () {
    const totalSupply = await token.totalSupply();
    expect(await token.balanceOf(accounts[0].address)).to.equal(totalSupply);
  });
});
