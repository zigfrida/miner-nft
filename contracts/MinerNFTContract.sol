pragma solidity 0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MinerNFT is ERC721, Ownable {

    address public VRFCoordinator;
    address public LinkToken;
    bytes32 internal keyHash;
    uint256 internal fee;

    uint256 public tokenCounter;

    struct MinerNFT {
        string MAC_hash;
        string Id;
    }

    MinerNFT[] public miners;

    constructor(address _VRFCoordinator, address _LinkToken, bytes32 _keyhash) ERC721("MinerNFT", "MNFT") public {
        VRFCoordinator = _VRFCoordinator;
        LinkToken = _LinkToken;
        keyHash = _keyhash;
        fee = 0.1 * 10**18; // 0.1 LINK
    }

    function newMiner(address recipient, string memory hash, string memory metadata) public returns (uint256) {
        uint256 newMinerId = tokenCounter;
        _mint(recipient, newMinerId);
        _setTokenURI(newMinerId, metadata);
        tokenCounter = tokenCounter + 1;
        return newMinerId;
    }


    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        return tokenURI(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _setTokenURI(tokenId, _tokenURI);
    }

}