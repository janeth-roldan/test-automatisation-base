@REQ_BTPMCDP-789 @HU1789 @administracion_personajes @bp_dev_test @Agente2 @E2 @personajes
Feature: BTPMCDP-118 Crear cuenta exitosamente (microservicio transversal para crear cuentas)
Feature: Test de API súper simple

  Background:
    * configure ssl = true

  Scenario: Verificar que un endpoint público responde 200
    Given url 'https://httpbin.org/get'
    When method get
    Then status 200

  Scenario: Obtener todos los personajes
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method get
    Then status 200

  Scenario: Obtener personaje por ID
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/84'
    When method get
    Then status 200

  Scenario: Crear personaje válido
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request read('classpath:data/spiderman.json')
    And header Content-Type = 'application/json'
    When method post
    Then status 201

  Scenario: Crear personaje con nombre duplicado (error 400)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request read('classpath:data/spiderman.json')
    And header Content-Type = 'application/json'
    When method post
    Then status 400

  Scenario: Crear personaje con datos inválidos (error 400)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request read('classpath:data/spidermanInvalid.json')
    And header Content-Type = 'application/json'
    When method post
    Then status 400

  Scenario: Obtener personaje inexistente (error 404)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/9999'
    When method get
    Then status 404

  Scenario: Actualizar personaje válido
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/84'
    And request read('classpath:data/spidermanUpdate.json')
    And header Content-Type = 'application/json'
    When method put
    Then status 200

  Scenario: Actualizar personaje inexistente (error 404)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/9999'
    And request read('classpath:data/spidermanUpdate.json')
    And header Content-Type = 'application/json'
    When method put
    Then status 404

  Scenario: Eliminar personaje válido
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/101'
    When method delete
    Then status 200

  Scenario: Eliminar personaje inexistente (error 404)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/9999'
    When method delete
    Then status 404
