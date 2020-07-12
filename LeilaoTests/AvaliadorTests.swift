//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Henrique Batista on 10/07/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class AvaliadorTests: XCTestCase {
    private var joao: Usuario!
    private var jose: Usuario!
    private var maria: Usuario!
    private var leiloeiro: Avaliador!
    
    override func setUp() {
        super.setUp()
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        leiloeiro = Avaliador()
    }
    
    func testDeveEntenderLancesEmOrdemCrescente() {
        // Cenario
        let leilao = CriadorDeLeilao().para("Playstation 4")
            .lance(maria, 250.0)
            .lance(joao, 300.0)
            .lance(jose, 400.0)
            .controi()
        
        // Acao
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao

        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testDeveEntenderLeilaoComApenasUmLance() {
        // Cenario
        let leilao = CriadorDeLeilao().para("Playstation 4")
            .lance(joao, 1300.0)
            .controi()

        
        // Acao
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        XCTAssertEqual(1300.0, leiloeiro.menorLance())
        XCTAssertEqual(1300.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaioresLances() {
        
        let leilao = CriadorDeLeilao().para("Playstation 4")
            .lance(maria, 250.0)
            .lance(joao, 600.0)
            .lance(maria, 850.0)
            .lance(joao, 300.0)
            .controi()
    
        try? leiloeiro.avalia(leilao: leilao)
        
        
        let listaDeLances = leiloeiro.treMaiores()
        
        XCTAssertEqual(3, listaDeLances.count)
        XCTAssertEqual(850, listaDeLances[0].valor)
        XCTAssertEqual(600, listaDeLances[1].valor)
        XCTAssertEqual(300, listaDeLances[2].valor)

    }
    
    func testDeveIgnorarLeilaoSemLances() {
        let leilao = CriadorDeLeilao().para("Playstation 4").controi()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possivel avaliar leilao sem lances") { (error) in
            print(error.localizedDescription)
        }
    }
}
