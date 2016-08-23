contract DSBaseNoFallback {
    function assert(bool condition) internal {
        if (!condition) throw;
    }
    // largely deprecated by better tracing tools
    function throws(bytes32 reason) internal {
        log1(msg.sig, reason);
        throw;
    }
    modifier noEther() {
        if( msg.value == 0 ) {
            _
        } else {
            throw;
        }
    }
}
contract DSBase is DSBaseNoFallback {
    // TODO: eventually you'll be able to override fallbacks
    function () {
        throw;
    }
}
