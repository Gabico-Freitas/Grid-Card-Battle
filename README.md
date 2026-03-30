# Grid-Card-Battle

## Fundamentos
* Grid = 5x5 (8x8 ?)
* Movimentos são ortogonais (sem DIAGONAL)
* Mana não utilizada é descartada
* Cartas não utilizadas são descartadas
* Atributos jogador
  * Movimento = 3 quadrados, balancear por algumas cartas
  * Vida = 36
  * Mana Regen. = 5 p/turno
  * Quantidade de cartas na mão
* Atributos Inimigos:
  * Vida
  * Movimento
  * Ataque(s)
  * IA

## Cartas
* Deck inicial = ?
* Tipos de carta:
  * Ataque (focar nisso primeiro):
    * De perto
    * À distância
  * Status/Movimento (Se der tempo)
  * Defesa (Se der tempo)
* Custo de cartas:
  * Baratas = 1
  * Médio = 2,3
  * Caras = 4

* Cartas Base (azul é o ataque):
  * Ataque 1 bloco (Custo: 1, Dano: 3) (x4)
  <img width="167" height="87" alt="image" src="https://github.com/user-attachments/assets/656b5226-01b2-4b53-98fd-3ea75455ca89" />
  
  * Ataque 3 blocos (Custo: 2, Dano: 4) (x3)
  <img width="304" height="79" alt="image" src="https://github.com/user-attachments/assets/b4dca830-b753-4575-9f3f-e7805d345e24" />
  
  * Ataque 3º bloco (Custo: 2, Dano: 7) (x2)
  <img width="304" height="78" alt="image" src="https://github.com/user-attachments/assets/b8fca0bc-d5b0-4be8-9584-21cc8c0c270d" />
  
  * Ataque três blocos na frente (Custo: 3, Dano: 6) (x2)
  <img width="230" height="230" alt="image" src="https://github.com/user-attachments/assets/c154d8c6-8770-48a6-a3ba-a1c04c3c7e82" />
  
  * Ataque 1 bloco que consome movimento (Custo: 1 + 2 movimento, Dano: 7) (x1)
  <img width="167" height="87" alt="image" src="https://github.com/user-attachments/assets/656b5226-01b2-4b53-98fd-3ea75455ca89" />
 
## Inimigos
* Peão
  * Ataque de perto = 1 bloco (5 de dano)
  * Vida = 25
  * Movimento = 2 quadrados
  * IA = Se move o mais próximo possível e ataca se possível
    
* Sniper
  * Ataque de longe = 3 blocos (8 de dano)
  * Vida = 15
  * Movimento = 1
  * IA = Testa se da pra atacar o jogador em algum quadrado adjacente, caso dê ataca, caso não se tenta se aproximar

* Morteiro
  * Ataque de perto = 1 bloco (3 de dano)
  * Vida = 28
  * Movimento = 0
  * IA = Se o jogador estiver na sua zona de alcance (x blocos) ele ataca

## OBSs
* Regen + 1, por cada instância de dano levada no último turno (cada hit).
* Algoritmo A*
