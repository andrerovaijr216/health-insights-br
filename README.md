# Desafio Final de Engenharia de Dados - Health Insights Brasil

## 🎯 Objetivo

Este projeto implementa uma pipeline de dados completa para ingerir, transformar e modelar dados públicos de internações hospitalares do DataSUS. O objetivo é criar uma fonte de dados confiável e performática (um Data Mart) para apoiar análises estratégicas de saúde pública, resolvendo o desafio da "Health Insights Brasil".

## 🏛️ Arquitetura da Solução

A arquitetura segue o modelo Medalhão, garantindo governança e qualidade em cada etapa do processo.

1.  **🥉 Camada Bronze (`bronze_internacoes_sih`):**
    *   **O quê:** Repositório de dados brutos.
    *   **Como:** Os dados são ingeridos do DataSUS (no nosso caso, a partir de um arquivo `.dbc` convertido para `.csv`) e armazenados em uma tabela Delta no Databricks sem transformações, garantindo a fidelidade à fonte original.

2.  **🥈 Camada Silver (`stg_sih_internacoes`):**
    *   **O quê:** Camada de dados limpos e padronizados.
    *   **Como:** Usando o dbt, criamos uma `view` que lê da camada Bronze, renomeia colunas para nomes de negócio claros, converte tipos de dados (ex: datas) e aplica limpezas básicas.

3.  **🥇 Camada Gold (`fato_internacoes`, `dim_paciente`):**
    *   **O quê:** Camada de dados agregados e prontos para o negócio.
    *   **Como:** Usando o dbt, criamos um modelo dimensional (Star Schema) com tabelas fato e dimensão, otimizado para análises e dashboards. A qualidade e a integridade são garantidas por testes de dados.

## 🛠️ Tecnologias Utilizadas

*   **Processamento e Data Lakehouse:** Databricks
*   **Transformação e Modelagem:** dbt (Data Build Tool)
*   **Ambiente de Desenvolvimento:** GitHub Codespaces
*   **Orquestração (Proposta):** Databricks Workflows
*   **Data Warehouse de Consumo (Proposta):** Snowflake

## 🚀 Como Rodar o Projeto

1.  **Pré-requisitos:** Ambiente configurado no GitHub Codespaces com acesso ao Databricks.
2.  **Ingestão:** Os dados brutos (`.csv`) são carregados no Databricks via UI, criando a tabela na camada Bronze.
3.  **Transformação:** Navegue até a pasta `dbt_project` no terminal e execute:
    ```bash
    # Executa todos os modelos (Bronze -> Silver -> Gold)
    dbt run
    ```
4.  **Teste de Qualidade:** Para garantir a integridade dos dados, execute:
    ```bash
    # Executa todos os testes definidos no schema.yml
    dbt test
    ```

## ✨ Inovação e Próximos Passos

*   **Integração com Snowflake:** As tabelas da camada Gold seriam exportadas para o Snowflake, que serviria como Data Warehouse de consumo para ferramentas de BI, garantindo a separação de cargas de trabalho.
*   **Dashboard em Tempo Quase Real:** Proposta de um dashboard em Streamlit ou Power BI conectado ao Snowflake para monitorar indicadores de saúde, como taxa de internações por CID-10 e por região.
*   **Orquestração Automatizada:** A pipeline seria orquestrada com Databricks Workflows para rodar diariamente, garantindo que os dados estejam sempre atualizados.