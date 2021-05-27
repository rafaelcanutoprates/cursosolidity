// SPDX-License-Identifier: CC-BY Rafael Prates-4.0
// Contrato criado inicialmente por Claudio Girao Barreto

pragma solidity 0.8.4;

    // Permite consultar a realizacao de treinamento em LGPD pelos colaboradores da empresa

contract ConsultaTreinamentoColaboradores {

    // mapeamento de município para subseção
    mapping (string => string) public cursos; 
    // etiqueta ou chave ou key -> nome do treinamento
    // e dentro do item será armazenado string (texto)

    mapping (uint => string) public regioes;
    // 1 -> DF
    // 2 -> RJ e ES 
    // 3 -> SP e MS 
    // 4 -> PR, SC, RS
    // 5 -> PE, AL, PB, RN, CE

    //Array de strings
    string[] public colaborador;
    // Atribuicao da chave é feita automaticamente pelo solidity
    // A chave é um numero inteiro sequencial

    string[] public areaDaEmpresa;

    constructor() {
    regioes[1] = "DF";
    regioes[2] = "RJ e ES";
    regioes[3] = "SP e MS";
    regioes[4] = "PR, SC, RS";
    regioes[5] = "PE, AL, PB, RN, CE";
    colaborador.push("rafael"); // 0
    areaDaEmpresa.push("marketing");
    colaborador.push("leonardo"); // 1
    areaDaEmpresa.push("comercial");

    }

    function incluirColaborador(string memory _nomeDoColaborador, string memory _areaDaEmpresa) public {
        colaborador.push(_nomeDoColaborador);
        areaDaEmpresa.push(_areaDaEmpresa);
    }

    function consultarNomeColaborador(uint _nomeDoColaborador) public view returns(string memory) {
        return colaborador[_nomeDoColaborador];
    }

    function consultarColaborador(uint _nomeDoColaborador) public view returns(string memory, string memory){
        return (colaborador[_nomeDoColaborador], areaDaEmpresa[_nomeDoColaborador]);
    }


    // permite vincular no mapping o treinamento ao modulo
    function incluirTreinamentoEmModulo(string memory _treinamento, string memory _modulo) public {
        cursos[_treinamento] = _modulo;
    }

    // consultar a subseção a que se vincula o município
    function consultarModuloDoTreinamento(string memory _treinamento) public view returns (string memory){
        return cursos[_treinamento];
    }
    }
