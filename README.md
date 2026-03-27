# Grid-Card-Battle

## Fundamentos
* Grid = 5x5 (8x8 ?)
* Movimentos são ortogonais (sem DIAGONAL)
* Mana não utilizada é descartada
* Atributos jogador
  * Movimento = 3 quadrados, balancear por algumas cartas
  * Vida = 36
  * Mana Regen. = 3 p/turno
  * Quantidade de cartas na mão
* Atributos Inimigos:
  * Vida
  * Movimento
  * Ataque(s)
  * IA

## Cartas
* Deck inicial = ?
* Tipos de carta:
  * Ataque
  * 
* 

## Inimigos
* Peão
  * Ataque de perto = 1 bloco (5 de dano)
  * Vida = 10
  * Movimento = 2 quadrados
  * IA = Se move o mais próximo possível e ataca se possível
    
* Sniper
  * Ataque de longe = 3 blocos (8 de dano)
  * Vida = 6
  * Movimento = 1
  * IA = Testa se da pra atacar o jogador em algum quadrado adjacente, caso dê ataca, caso não se tenta se aproximar

* Morteiro
  * Ataque de perto = 1 bloco (3 de dano)
  * Vida = 14
  * Movimento = 0
  * IA = Se o jogador estiver na sua zona de alcance (x blocos) ele ataca

## OBSs
* Regen + 1, por cada instância de dano levada no último turno (cada hit).
* Algoritmo A*
