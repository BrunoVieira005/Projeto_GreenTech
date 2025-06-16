# GreenTech: Irrigação Inteligente para uma Agricultura Sustentável 🌿💧

Este repositório contém o projeto **GreenTech**, um sistema inovador de irrigação inteligente focado em otimizar o uso da água e aumentar a eficiência na produção agrícola. Desenvolvido por Murilo Silva, Camila Ramos e Bruno Vieira, o GreenTech integra hardware (sensores simulados) e software (aplicativo móvel e chatbot) para oferecer uma solução completa aos agricultores.

## Visão Geral do Projeto

O GreenTech nasceu da necessidade de tornar a irrigação mais precisa e sustentável. Nosso sistema permite o monitoramento em tempo real das condições do solo e do clima **(com dados simulados por uma API própria)**, automatizando a irrigação com base nesses dados para reduzir desperdícios e otimizar o crescimento das culturas.

## Funcionalidades Principais

Nosso aplicativo e sistema oferecem diversas funcionalidades para o controle eficiente da irrigação:

* **Monitoramento de Dados Simulados:** Acompanhe dados cruciais como temperatura, umidade do solo, luminosidade e velocidade do vento, **gerados por uma API desenvolvida em FastAPI que simula as leituras de sensores.**
* **Controle de Irrigação:** Controle a irrigação com base nos dados medidos.
* **Histórico Detalhado:** Acesse logs completos de irrigação, com data, hora e volume de água utilizado, para um controle preciso.
* **Chatbot Inteligente:** Um assistente virtual integrado que oferece recomendações sobre cultivos, dicas de plantio e otimização da produção (ex: como preparar o solo para cenouras).
* **Interface Intuitiva:** Aplicativo móvel com design amigável para uma experiência de usuário simples e eficiente.


## Estrutura do Projeto

O projeto GreenTech é composto por:

* **Aplicativo Móvel:** Voltado para dispositivos Android, e feito utilizando o framework Flutter
* **API de Dados de Sensores:** **Uma API RESTful desenvolvida em FastAPI que simula a coleta de dados de sensores (temperatura, umidade, etc.).**


## Tecnologias Utilizadas

* **Linguagens de Programação:** Dart
* **Frameworks/Bibliotecas:** FastAPI (para a API de dados), Flutter (para desenvolvimento do app)
* **Inteligência Artificial (Chatbot):**
    * **Modelo de Linguagem (LLM):** Llama3-8b-8192
    * **API de Inferência:** Groq API
    * **Hospedagem:** Hugging Face
    * **Orquestração de Fluxos:** Langflow
* **Simulação de Hardware:** API com rotas personalizadas para gerar dados randômicos e simulação de acionamento da bomba
* **Outras Ferramentas:** Um assistente virtual avançado, **alimentado pelo modelo de linguagem Llama3-8b-8192 e otimizado, via Groq API, e o fluxo de conversa orquestrado pelo **Langflow**.


## Contribuições

Este projeto foi desenvolvido como parte de um Projeto Integrador, pela faculdade de Tecnologia SENAI Roberto Mange. Contribuições e sugestões são bem-vindas! Sinta-se à vontade para abrir "issues" ou entrar em contato.


## Equipe

* **Bruno Vieira** [![GitHub](https://img.shields.io/badge/GitHub-%23121011.svg?logo=github&logoColor=white)](https://github.com/BrunoVieira005)
* **Murilo Silva** [![GitHub](https://img.shields.io/badge/GitHub-%23121011.svg?logo=github&logoColor=white)](https://github.com/Murilosxv)
* **Camila Ramos** [![GitHub](https://img.shields.io/badge/GitHub-%23121011.svg?logo=github&logoColor=white)](https://github.com/CamilaTamires)
