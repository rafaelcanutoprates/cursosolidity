/* SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Rafael Prates */

pragma solidity 0.8.4;

contract CartolaApostas {

    struct Participante {
        string nomeDoParticipante;
        address payable enderecoCarteira;
        uint nomeDoTime;
        uint pontuacaoNaRodada;
        bool jaHouveUmVencedor;  
    }
    
    address payable public contaDoVencedor;
    address payable public carteiraPlataforma;
    uint public fimDaRodada;

    address public maiorPontuador;
    uint public maiorPontos;
    
    uint constant public taxaDaPlataforma = 5;

    mapping(address => Participante) public listaPontuacoes;
    Participante[] public pontuacoes;

    bool public rodadaEncerrada;

    event encerramentoDaRodada(address maiorPontuador, uint valor);

    modifier somentePlataforma {
        require(msg.sender == carteiraPlataforma, "Somente o Adm pode realizar concluir essa operacao");
        _;
    }

    constructor( 
        uint _duracaoRodada,
        address payable _contaDoVencedor,
        address payable _carteiraPlataforma
    ) {
        contaDoVencedor = _contaDoVencedor;
        fimDaRodada = block.timestamp + _duracaoRodada;
        carteiraPlataforma = _carteiraPlataforma;
    }


    function pontos(string memory nomeParticipante, address payable enderecoCarteiraParticipante) public payable {
        require(block.timestamp <= fimDaRodada, "Rodada Encerrada");
        require(msg.value > maiorPontos, "Outro Jogador tem uma pontuacao maior");
        
        maiorPontuador = msg.sender;
        maiorPontos = msg.value;


        for (uint i=0; i<pontuacoes.length; i++) {
            Participante storage participantePerdedor = pontuacoes[i];
            if (!participantePerdedor.jaHouveUmVencedor) {
                uint valorReembolsoParticipante = (participantePerdedor.pontuacaoNaRodada * (100-taxaDaPlataforma))/100;
                participantePerdedor.enderecoCarteira.transfer(valorReembolsoParticipante);
                uint valorComissaoPlataforma = (participantePerdedor.pontuacaoNaRodada * 100-taxaDaPlataforma)/100;
                carteiraPlataforma.transfer(valorComissaoPlataforma);
                participantePerdedor.jaHouveUmVencedor = true;
            }
        }
        
    }

        function finalizaRodada() public somentePlataforma {
       
        require(block.timestamp >= fimDaRodada, "Rodada ainda nao encerrada.");
        require(!rodadaEncerrada, "Rodada Encerrada.");


        contaDoVencedor.transfer(address(this).balance);
    }
    
    function retornaMaiorPontuador() public view somentePlataforma returns (address) {
        return maiorPontuador;
    }
}
