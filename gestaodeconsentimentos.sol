// SPDX-License-Identifier: CC-BY Rafael Prates-4.0

pragma solidity 0.8.4;

contract gestaoDeConsentimentos {
    
    string public consentimento;
    bool public deuConsentimento;
    bool public naoDeuConsentimento;
    
    constructor (string memory  _titulardedados) {
        consentimento = _titulardedados;
    }
    
    function verificaSeOTitularDeuConsentimento ()
    public
    view
    returns (bool resposta) {   
        if (deuConsentimento != naoDeuConsentimento) {
            return true;
        } else {
            return false;
        }
    }
        
    function retirarConsentimento ()
    public
    view
    returns (bool) {
        if (naoDeuConsentimento) {
            return true;
        }   else {
            return false;
        }
    }
}
