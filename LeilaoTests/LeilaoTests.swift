//
//  LeilaoTests.swift
//  LeilaoTests
//
//  Created by Ândriu Coelho on 27/04/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class LeilaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeveReceberUmLance() {
        let leilao = Leilao(descricao: "MacBook Pro 15")
        XCTAssertEqual(0, leilao.lances?.count)
        
        let steve = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(steve, 4000.0))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(4000.0, leilao.lances?.first?.valor)
    }
    
    func testDeveReceberVariosLances() {
        let leilao = Leilao(descricao: "MacBook Pro 15")
        XCTAssertEqual(0, leilao.lances?.count)
        
        let steve = Usuario(nome: "Steve Jobs")
        let joao = Usuario(nome: "Joao")
        let maria = Usuario(nome: "Maria")
        
        leilao.propoe(lance: Lance(steve, 1000))
        leilao.propoe(lance: Lance(joao, 2000))
        leilao.propoe(lance: Lance(maria, 3000))
        leilao.propoe(lance: Lance(steve, 4000))
        leilao.propoe(lance: Lance(maria, 5000))
        
        XCTAssertEqual(5, leilao.lances?.count)
        XCTAssertEqual(1000, leilao.lances?.first?.valor)
        XCTAssertEqual(2000, leilao.lances?[1].valor)

    }
    
    func testDeveIgnorarDoisLancesSeguidosDoMesmoUsuario() {
        let leilao = Leilao(descricao: "MacBook Pro 15")
        
        let steve = Usuario(nome: "Steve Jobs")
        leilao.propoe(lance: Lance(steve, 1000))
        leilao.propoe(lance: Lance(steve, 2000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(1000, leilao.lances?.first?.valor)


    }
    
    func testDeveIgnorarMaisDeCincoLancesDoMesmoUsuario() {
        let leilao = Leilao(descricao: "MacBook Pro 15")

        let joao = Usuario(nome: "Joao")
        let maria = Usuario(nome: "Maria")
        
        leilao.propoe(lance: Lance(joao, 2000))
        leilao.propoe(lance: Lance(maria, 3000))
        
        leilao.propoe(lance: Lance(joao, 4000))
        leilao.propoe(lance: Lance(maria, 5000))
        
        leilao.propoe(lance: Lance(joao, 6000))
        leilao.propoe(lance: Lance(maria, 7000))
        
        leilao.propoe(lance: Lance(joao, 8000))
        leilao.propoe(lance: Lance(maria, 9000))
        
        leilao.propoe(lance: Lance(joao, 10000))
        leilao.propoe(lance: Lance(maria, 11000))
        
        // Deve Ignorar
        
        leilao.propoe(lance: Lance(joao, 12000))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(11000, leilao.lances?.last?.valor)

    }
    
}
