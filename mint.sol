// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract InkWNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _tokenId;

    string private baseURI;
    address contractOwner;


    event InkWorkNFTMinted(address player, uint256[] tokenIds);

    constructor(
        string memory _name,
        string memory _symbol   
    ) ERC721(_name, _symbol) {
        contractOwner = msg.sender;
        baseURI = "https://sapphire-tremendous-bonobo-765.mypinata.cloud/ipfs/QmbvupkKZVPNwFBu8APnh8vSWJ3ShbfiHjE2hmk3Xgaxkh/";
    }

    function mintInkWorkNFT(address to) external {
        uint256[] memory outputIDs = new uint256[](50); 
        for (uint256 i = 0; i < 50; i++) {
            _tokenId.increment();
            uint tokenId = _tokenId.current();
            outputIDs[i] = tokenId;
            _safeMint(to, tokenId);
            _setTokenURI(tokenId, string(abi.encodePacked(baseURI, tokenId.toString(), ".json")));
        }
            emit InkWorkNFTMinted(to, outputIDs);
    }

    function approve(address to, uint256 tokenId) public virtual override {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(
            msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _approve(to, tokenId);
    }

}