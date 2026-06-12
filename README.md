
# 📈 Bank Fraud Detection Analytics

<p align="left">
A financial fraud detection project built on a simulated banking environment with 50,000 transactions.
</p>

---

## 📖 Project Overview

This project simulates a banking transaction ecosystem to identify potentially fraudulent activities using business rules implemented in SQL Server.

A complete relational database was designed, synthetic data was generated with Python, and analytical SQL queries were developed to detect suspicious transaction patterns.

---

## 🚀 Technologies Used

<p align="left">
<img src="https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white">
<img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white">
</p>

---

## 📊 Dataset

<table>
<tr>
<th>Entity</th>
<th>Records</th>
</tr>

<tr>
<td>Customers</td>
<td>1,000</td>
</tr>

<tr>
<td>Accounts</td>
<td>~2,000</td>
</tr>

<tr>
<td>Cards</td>
<td>~3,000</td>
</tr>

<tr>
<td>Merchants</td>
<td>100</td>
</tr>

<tr>
<td>Transactions</td>
<td>50,000</td>
</tr>

</table>

---

## 🏗 Database Schema

```text
Customers
   │
   └── Accounts
            │
            └── Cards
                      │
                      └── Transactions
                                 │
                                 └── FraudAlerts
```


## 👨‍💻 Author

Leonardo Martín Angulo Mogollón

Data Analyst | Business Intelligence | Databricks Certified
