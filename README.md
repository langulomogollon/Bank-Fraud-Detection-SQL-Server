<h1 align="center">
💳 Bank Fraud Detection Analytics
</h1>

<h3 align="center">
SQL Server | Python | Power BI
</h3>

<p align="center">
Proyecto de análisis y detección de fraude financiero utilizando una base de datos bancaria simulada con 50,000 transacciones.
</p>

---

## 📖 Descripción

Este proyecto simula el ecosistema transaccional de una entidad financiera con el objetivo de identificar operaciones potencialmente fraudulentas mediante reglas de negocio implementadas en SQL Server.

Se desarrolló una base de datos relacional completa, se generaron datos sintéticos con Python y se construyeron consultas analíticas para detectar patrones sospechosos.

---

## 🚀 Tecnologías

<p align="left">
<img src="https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white">
<img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white">
<img src="https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white">
</p>

---

## 📊 Dataset

<table>
<tr>
<th>Entidad</th>
<th>Registros</th>
</tr>

<tr>
<td>Clientes</td>
<td>1,000</td>
</tr>

<tr>
<td>Cuentas</td>
<td>~2,000</td>
</tr>

<tr>
<td>Tarjetas</td>
<td>~3,000</td>
</tr>

<tr>
<td>Comercios</td>
<td>100</td>
</tr>

<tr>
<td>Transacciones</td>
<td>50,000</td>
</tr>

</table>

---

## 🏗 Modelo de Datos

```text
Clientes
   │
   └── Cuentas
            │
            └── Tarjetas
                      │
                      └── Transacciones
                                 │
                                 └── AlertasFraude
