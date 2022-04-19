pragma solidity ^0.8.10;

/// @dev EIP712 helpers for features.
abstract contract EIP712 {
    /// @dev The domain hash separator for the entire exchange proxy.
    bytes32 public EIP712_DOMAIN_SEPARATOR;

    function setAddressForEipDomain(address hookAddress) internal {
        // Compute `EIP712_DOMAIN_SEPARATOR`
        {
            uint256 chainId;
            assembly {
                chainId := chainid()
            }
            EIP712_DOMAIN_SEPARATOR = keccak256(
                abi.encode(
                    keccak256(
                        "EIP712Domain("
                        "string name,"
                        "string version,"
                        "uint256 chainId,"
                        "address verifyingContract"
                        ")"
                    ),
                    keccak256("Hook"),
                    keccak256("1.0.0"),
                    chainId,
                    hookAddress
                )
            );
        }
    }

    function _getEIP712Hash(bytes32 structHash)
        internal
        view
        returns (bytes32 eip712Hash)
    {
        return
            keccak256(
                abi.encodePacked(hex"1901", EIP712_DOMAIN_SEPARATOR, structHash)
            );
    }
}
