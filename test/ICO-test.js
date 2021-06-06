/* eslint-disable comma-dangle */
/* eslint-disable no-unused-expressions */
/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */
const { expect } = require('chai');

describe('Initial Coin Offering (ICO) contract', function () {
  let token;
  let accounts;
  const amount = ethers.utils.parseEther('1');

  before(async () => {
    const contract = await ethers.getContractFactory('ICO');
    token = await contract.deploy();
    accounts = await ethers.getSigners();
    await token.deployed();
  });

  it('Assigns initial balance', async function () {
    const totalSupply = await token.totalSupply();
    expect(await token.balanceOf(accounts[0].address)).to.equal(totalSupply);
  });

  it('Do not have permission to minting token', async function () {
    const wallet = token.connect(accounts[2]);
    await expect(wallet.mint(accounts[2].address, amount)).to.be.reverted;
  });

  it('Buy token with ether', async function () {
    const wallet = token.connect(accounts[2]);
    const option = { value: amount };
    const calculate = option.value.mul(1000); // 1000 is declare in smart-contract msg.value * 1000
    await wallet.buy(option);
    expect(await wallet.balanceOf(accounts[2].address)).to.equal(calculate);
  });

  it('Do not have permission to withdraw ether from contract', async function () {
    const wallet = token.connect(accounts[2]);
    await expect(wallet.withdraw(amount)).to.be.reverted;
  });

  it('Transfer adds amount to destination account', async function () {
    await token.transfer(accounts[1].address, amount);
    expect(await token.balanceOf(accounts[1].address)).to.equal(amount);
  });

  it('Transfer emits event', async () => {
    await expect(token.transfer(accounts[1].address, amount))
      .to.emit(token, 'Transfer')
      .withArgs(accounts[0].address, accounts[1].address, amount);
  });

  it('Can not transfer above the amount', async () => {
    const wallet = token.connect(accounts[3]);
    await expect(wallet.transfer(accounts[1].address, 1)).to.be.reverted;
  });

  it('Can not transfer from empty account', async () => {
    const wallet = token.connect(accounts[3]);
    await expect(wallet.transfer(accounts[0].address, 1)).to.be.reverted;
  });
});
