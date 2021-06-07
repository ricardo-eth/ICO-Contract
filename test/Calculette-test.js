/* eslint-disable comma-dangle */
/* eslint-disable no-unused-expressions */
/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */
const { expect } = require('chai');

describe('Cal', function () {
  beforeEach(async function () {
    [owner] = await ethers.getSigners();

    // Cal Deployment
    Cal = await ethers.getContractFactory('Cal');
    Cal = await Cal.connect(dev).deploy(owner.address);
    await Cal.deployed();
  });
});
