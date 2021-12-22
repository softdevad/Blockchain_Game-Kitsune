pragma solidity ^0.5.0

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract NFTContract is ERC1155, Ownable{
    uint public constant GOLD = 0;
    uint public constant SILVER = 1;
    uint public constant LEGENDARY_SWORD = 2;

    constructor() ERC1155("") {
        _mint(msg.sender, GOLD, 1, "")
        _mint(msg.sender, SILVER, 1, "")
        _mint(msg.sender, LEGENDARY_SWORD, 1, "")
    } //At this point this is fully functional. Prblm now is that you can't mint more NFTs from this.
    // mintRate for ERC1155.  Made public so people can see what the mintRate is.
    uint public mintRate = 0.05;

    // Build a mint function that allows to mint more NFTs in the future.
    // Create a PUBLIC mint function that is a wrap around (makes it possible) to call the internal mint function.
    // Problem: Anyone can call it, need to create better security restrictions on it. Add the "require" statment.
    function mint(address account, uint256 id, uint amount) public onlyOwner {
        require(msg.value >= (amount * mintRate), "Not enough ether sent.");
        _mint(account, id, amount, "");
    }

    function burn(address account, uint id, uint amount) public {
        // Make it so that only the Token Owner can burn their Tokens.
        require(msg.sender == account);
        _burn(account, id, amount);
    }
}