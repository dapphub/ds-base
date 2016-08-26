contract DSBaseNoFallback {
    function assert(bool condition) internal {
        if (!condition) throw;
    }
    // largely deprecated by better tracing tools
    function throws(bytes32 reason) internal {
        log1(msg.sig, reason);
        throw;
    }
    // this may be default in future: https://github.com/ethereum/solidity/pull/665
    modifier noEther() {
        assert( msg.value == 0 );
        _
    }
    // N.B. In older solidity versions, this cannot be used on functions
    // with a `return` statement. This restriction is lifted now
    // (https://github.com/ethereum/solidity/commit/9c8310)
    bool _mutex;
    modifier mutex() {
        assert(!_mutex);
        _mutex = true;
        _
        _mutex = false;
    }

    // check for overflowing math. N.B. throw-on-overflow may be
    // default in future: https://github.com/ethereum/solidity/issues/796
    function safeToAdd(uint a, uint b) internal returns (bool) {
        return (a + b >= a);
    }

    function safeToSub(uint a, uint b) internal returns (bool) {
        return (a >= b);
    }

    function safeToMul(uint a, uint b) internal returns (bool) {
        var c = a * b;
        return (a == 0 || c / a == b);
    }
}
contract DSBase is DSBaseNoFallback {
    // TODO: eventually you'll be able to override fallbacks
    function () {
        throw;
    }
}
