/*
   Copyright 2016 Nexus Development

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

pragma solidity ^0.4.2;


contract DSBase {
    function assert(bool condition) internal {
        if (!condition) throw;
    }

    bool _ds_mutex;
    modifier mutex() {
        assert(!_ds_mutex);
        _ds_mutex = true;
        _;
        _ds_mutex = false;
    }

    function tryExec( address target, bytes calldata, uint value)
             mutex()
             internal
             returns (bool call_ret)
    {
        return target.call.value(value)(calldata);
    }
    function exec( address target, bytes calldata, uint value)
             internal
    {
        assert(tryExec(target, calldata, value));
    }

    

    // TODO Keep up with this https://github.com/ethereum/solidity/issues/796
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
