# Petfinder

## 1. Descrição Geral

Neste documento são detalhadas as entregas referentes ao projeto de banco de dados da disciplina. Este projeto poderá ser desenvolvido individualmente ou em duplas e contará com 3 entregas:

- **1ª entrega:** pré-projeto – descrição do problema a ser resolvido;
- **2ª entrega:** projeto lógico – definição do modelo Entidade Relacionamento (ER) e do esquema lógico inicial do banco de dados;
- **3ª entrega:** esquema físico SQL – entrega final dos scripts SQL do banco de dados gerado.

A entrega irá constar apenas dos scripts SQL gerados e de atualizações (caso existam) dos modelos ER e lógico da 2ª entrega.

Essas entregas deverão ser realizadas por meio de tarefa própria no e-aula seguindo o seguinte cronograma:

| Entrega      | Data limite    |
|--------------|----------------|
| 1ª entrega   | até 20/05/2025 |
| 2ª entrega   | até 06/06/2025 |
| 3ª entrega   | 15/08/2025     |

Cada uma das entregas está detalhada nas seções de 2 a 4 a seguir.

---

## 2. Descrição da 1ª Entrega – Pré-Projeto

A 1ª entrega (pré-projeto) diz respeito à descrição do problema em si a ser tratado, ou seja, a que irá se destinar o banco de dados a ser desenvolvido.

Para isso, o grupo irá descrever, além do problema, a realidade a ser modelada, destacando:

- **Quem são os principais atores** neste sistema, sejam usuários ou estruturas de software que produzem os dados;
- **Quais as principais transações** (processamento) a que se destinará o banco de dados;
- **Os principais dados manipulados** por essas transações (as entradas e saídas de dados).

Além destes itens enfatizados, poderão descrever outros aspectos que o grupo considere importante para compreensão do problema e do sistema a ser desenvolvido.

A sugestão é que cada um destes itens seja uma subseção do pré-projeto a ser entregue.

É importante que o grupo descreva qual o objetivo geral do banco de dados, isto é, a quê se destina (por exemplo, armazenar dados referentes aos produtos manufaturados e projetos desenvolvidos em uma marcenaria).

Ainda, é importante identificar quem serão os usuários do banco de dados, como irão utilizá-lo e para quê utilizarão o banco. Isso é necessário para identificar as transações que ocorrem nele (no exemplo da marcenaria, identificar que um funcionário é responsável pela gerência dos vários projetos solicitados por cada cliente, sendo preciso identificar valor do projeto, materiais a ser comprados, data do pedido, data da entrega).

A partir dessas transações é que os grupos irão conseguir detalhar as entidades que fazem parte das transações (funcionário, cliente, fornecedor, matéria prima,...), seus relacionamentos, cardinalidades e atributos.

Quanto melhor o grupo detalhar o problema e a realidade (minimundo) a que o banco se destina, mais simples será o desenvolvimento do restante do projeto.

Podem ser descritos processos a serem realizados pelo sistema, apesar de não serem efetivamente tratados no trabalho (por exemplo, checagem do projeto do cliente, se está finalizado ou não – o banco pode apenas armazenar um campo “status do projeto”, sem que o processo de identificação desse estado seja especificado no trabalho).

Esses processos podem ser descritos nos requisitos como ações realizadas pelos usuários do banco ou então a serem implementadas no sistema.

Isso irá ajudar a modelar as telas ao final do trabalho, com as entradas e saídas de dados refletindo as funcionalidades do sistema idealizado e descrito nos requisitos.

---

**Formato da entrega:**

- Será feita na forma de texto extensão **.pdf** (para permitir a correção no e-aula);
- Enviada por apenas um dos integrantes do grupo;
- Pode usar o formato desta descrição ou formato LaTeX (sugestão para artigos SBC);
- Nome do arquivo: `Grupo{num.grupo}_pre-projeto.pdf`;
- Identificar dentro do documento o nome dos integrantes.

---

**Tamanho do problema:**

Os grupos devem conseguir identificar, na descrição do problema, a necessidade de modelar posteriormente no DER um mínimo de **6 entidades** e de **2 a 3 relacionamentos N:M**.

Esse requisito é importante para que tenhamos projetos nem muito pequenos e nem muito grandes.

Casos específicos, em que os grupos terão menos entidades, mas que percebam que irão gerar mais tabelas, ou em que terão bem mais entidades, mas que percebam que será um desenvolvimento adequado para o tempo, devem ser reportados ao professor para registro.

---

## 3. Descrição da 2ª Entrega – Modelos ER e Lógico

Com base no problema descrito no pré-projeto, a 2ª entrega consiste dos modelos Entidade-Relacionamento (ER) e lógico do esquema do banco de dados a ser criado.

### Modelo ER

- Deve ser completo, constando de entidades, atributos e relacionamentos identificados;
- O que não puder ser descrito na forma de diagrama (padronização vista nas aulas) poderá ser descrito de forma textual;
- Pode ser feito em qualquer ferramenta de diagramação escolhida pelo grupo;
- O diagrama ER (DER) e as restrições de integridade em texto (caso necessárias) devem constar em **1 único documento .pdf** para facilitar a correção.

### Modelo Lógico

- Mapeamento do DER para tabelas do Modelo Relacional;
- Consiste em todas as tabelas a serem criadas no banco de dados, suas chaves primárias, estrangeiras, tipos de dados (ex: string ou inteiro) e demais restrições de integridade;
- Deve seguir a especificação textual usada nas aulas:

Exemplo:

```sql
T1(chavePrimariaT1, atributo1T1, atributo2T1)
T2(chavePrimariaT2, atributo1T2, atributo2T2, atributo3T2, atributo4T2)
atributo4T2 Referencia T1 (chavePrimariaT1)
```
---

### Vídeo da 2ª entrega

- Vídeo de até 10 minutos descrevendo o DER e o projeto lógico desenvolvido;
- Todos os integrantes devem participar do vídeo;
- Pode usar slides para facilitar a explicação;
- Enviar o link para acesso ao vídeo na tarefa do e-aula;
- Caso haja muitas mudanças em relação à 1ª entrega, entregar nova especificação coerente ao DER desenvolvido.

---

## 4. Descrição da 3ª Entrega – Apresentação do BD

A 3ª entrega consistirá dos scripts SQL do banco de dados desenvolvido.

### Scripts devem conter:

- Comandos de criação das tabelas;
- Demais restrições de integridade e funções criadas;
- Scripts de inserções de dados no banco;
- Consultas – mínimo **6 consultas**, sendo **4 delas com junção entre tabelas**;
- Processamento de BD ativo – mínimo **1 procedimento iniciado por gatilho**;
  - Definir no mínimo 1 regra que precise ser verificada durante a manipulação dos dados, para manter restrição de integridade por gatilho.

---

### Documentação

- Caso tenham sido feitas alterações no DER após a 2ª entrega, deve ser enviado o DER atualizado junto com os scripts.

---

### Apresentação final

- Desenvolvimento de interfaces para comunicação com o banco (entrada e saída de dados) e interação;
- Aplicação final que será apresentada ao usuário cliente;
- Apresentação feita para a professora com a presença de todos os integrantes do grupo;
- Data e horário marcados individualmente com cada grupo.

---

### IMPORTANTE

- Caso o grupo realize mudanças de especificação de requisitos entre as entregas, deve informar essas mudanças na documentação enviada;
- Na 3ª entrega, caso tenha sido realizada com base em DER e modelo lógico diferente do entregue na 2ª entrega, anexar os novos modelos gerados.

