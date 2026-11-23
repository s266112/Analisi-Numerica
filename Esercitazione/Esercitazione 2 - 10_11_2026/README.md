# 📐 Esercitazione 2 – Interpolazione polinomiale 🧮

🎯 **Obiettivo:** studiare l'interpolazione polinomiale e vedere come la scelta dei nodi (equispaziati, Chebyshev-Gauss, Chebyshev-Gauss-Lobatto) cambia la qualità dell'approssimazione, con il classico **fenomeno di Runge** 🌊.

---

## 🗂️ Struttura del progetto

```
📁 Esercitazione2/
├── 🔧 interpol.m              → polinomio interpolatore (polyfit + polyval)
├── 🔧 chebgauss.m             → nodi di Chebyshev-Gauss (CG)
├── 🔧 chebgausslob.m          → nodi di Chebyshev-Gauss-Lobatto (CGL)
├── ▶️ script_nodi.m           → punti a, b, c: nodi CG, CGL e interpretazione geometrica
├── ▶️ script_confronto.m      → punto d: confronto CG / CGL con n = 5 e n = 35
├── ▶️ script_runge.m          → punti e1, e2: Runge con grado 12 + tabella gradi 2–14
├── ▶️ script_convergenza.m    → punto f: errori per k = 1, 3, …, 31
├── 📄 nodi.txt
├── 📄 confronto.txt
├── 📄 runge.txt
├── 📄 convergenza.txt
├── 📝 Relazione.docx / Relazione.pdf
└── 📖 README.md
```

---

## ▶️ Come si esegue

Apri MATLAB nella cartella del progetto e scrivi nella **Command Window**:

```matlab
>> script_nodi           % Figure 1, 2, 3  → nodi.txt
>> script_confronto      % Figure 4, 5     → confronto.txt
>> script_runge          % Figure 6, 7     → runge.txt
>> script_convergenza    % Figura 8        → convergenza.txt
```

🧪 Per provare le function da sole:

```matlab
>> t = interpol([-2 1 3], [-2 11 17], [-2 1 3 0])   % → -2, 11, 17, 7.2
>> xc = chebgauss(-1, 1, 3)                          % → -0.8660, 0, 0.8660
>> xc = chebgausslob(-1, 1, 3)                       % → -1, 0, 1
```

---

## 🔧 Le function

| Function | Chiamata | Output / note |
|---|---|---|
| 🧩 `interpol` | `t = interpol(x, y, s)` | `t` = valori in `s` del polinomio di grado n−1 che passa per le n coppie (x, y). Vettore colonna. Si ferma se `x` e `y` hanno lunghezze diverse o se i nodi non sono distinti. |
| 🎯 `chebgauss` | `xc = chebgauss(a, b, m)` | `xc` = m nodi CG in [a, b], **colonna e in ordine crescente**. Nessun nodo coincide con a o b. |
| 🎯 `chebgausslob` | `xc = chebgausslob(a, b, m)` | `xc` = m nodi CGL in [a, b], **colonna e in ordine crescente**, con **a e b compresi**. Errore se m = 1 (divisione per m − 1 = 0). |

---

## 📐 Formule

✏️ **Problema di interpolazione:**

$$p_n(x_k)=y_k,\qquad k=0,\dots,n$$

✏️ **Forma di Lagrange:**

$$p_n(x)=\sum_{k=0}^{n}y_k\,L_k(x)$$

✏️ **Errore di interpolazione:**

$$f(x)-p_n(x)=\frac{f^{(n+1)}(\xi)}{(n+1)!}\prod_{i=0}^{n}(x-x_i)$$

✏️ **Nodi equispaziati:**

$$x_k=a+k\,\frac{b-a}{n},\qquad k=0,\dots,n$$

✏️ **Nodi di Chebyshev** (da [−1, 1] a [a, b]):

$$x_k=\frac{a+b}{2}+\frac{b-a}{2}\,t_k$$

$$\text{CG:}\quad t_k=-\cos\left(\frac{2k+1}{2n+2}\,\pi\right)\qquad\qquad \text{CGL:}\quad t_k=-\cos\left(\frac{k\pi}{n}\right)$$

✏️ **Funzione di Runge:**

$$f(x)=\frac{1}{1+x^2},\qquad x\in[-5,5]$$

✏️ **Errore misurato** (griglia di 1000 punti):

$$\|f-p_k\|_\infty\approx\max_{j=1,\dots,1000}|f(s_j)-p_k(s_j)|$$

✏️ **Teorema di Bernstein** (nodi di Chebyshev, f ∈ C²):

$$\|f-p_n\|_\infty=O\left(n^{-1/2}\right)$$

---

## 📊 Risultati

### 🎯 Addensamento dei nodi in [−1, 1] (`nodi.txt`)

| Nodi | m | Distanza agli estremi | Distanza al centro | Centro / estremi |
|---|---|---|---|---|
| CG | 10 | 9.6682e−02 | 3.1287e−01 | 3.24 |
| CG | 20 | 2.4547e−02 | 1.5692e−01 | 6.39 |
| CGL | 10 | 6.0307e−02 | 3.4730e−01 | 5.76 |
| CGL | 20 | 1.3639e−02 | 1.6516e−01 | 12.11 |

🔍 Verifica geometrica CGL: max |proiezioni − nodi CGL| = **3.3e−16** (zero di macchina ✅)

### ↔️ Confronto CG / CGL (`confronto.txt`)

| n | CG: x₁ − a | CGL: x₁ − a | CGL contengono gli estremi? |
|---|---|---|---|
| 5 | 4.8943e−02 | 0 | ✅ sì |
| 35 | 1.0069e−03 | 0 | ✅ sì |

### 🌊 Runge, gradi 2–14 (`runge.txt`)

| Grado | Equisp. | CGL |
|---|---|---|
| 2 | 6.4623e−01 | 6.4623e−01 |
| 4 | 4.3835e−01 | 4.5998e−01 |
| 6 | 6.1693e−01 | 3.1119e−01 |
| 8 | 1.0452e+00 | 2.0467e−01 |
| 10 | 1.9156e+00 | 1.3219e−01 |
| 12 | 3.6629e+00 | 8.4390e−02 |
| 14 | 7.1923e+00 | 5.3507e−02 |

(tabella completa con anche i gradi dispari in `runge.txt` 📄)

### 📉 Convergenza, k = 1, 3, …, 31 (`convergenza.txt`)

| Grado | Equisp. 🔴 | CGL 🔵 | CG 🟢 |
|---|---|---|---|
| 1 | 9.6151e−01 | 9.6151e−01 | 9.2590e−01 |
| 7 | 2.4734e−01 | 4.5958e−01 | 3.9172e−01 |
| 9 | 3.0028e−01 | 3.1907e−01 | 2.6916e−01 |
| 15 | 2.1069e+00 | 9.9308e−02 | 8.3094e−02 |
| 21 | 1.7602e+01 | 3.0214e−02 | 2.5262e−02 |
| 25 | 7.5764e+01 | 1.3649e−02 | 1.1411e−02 |
| 31 | **7.0408e+02** 💥 | **4.1429e−03** ✅ | **3.4635e−03** ✅ |

---

## 🔬 Comportamento osservato vs teoria

| Nodi | Cosa succede all'errore | Rapporto ogni 2 gradi | Convergenza uniforme? | Teoria |
|---|---|---|---|---|
| 🔴 Equispaziati | scende fino a k = 7, poi **esplode** | ≈ 2 (raddoppia) | ❌ **no** | fenomeno di Runge: il prodotto ∏(x − xᵢ) è enorme vicino agli estremi |
| 🔵 CGL | scende sempre, retta in semilogy | ≈ 0.67 | ✅ **sì** | Bernstein garantisce O(n^−1/2); osservato molto più veloce (al grado 31: 0.0041 contro 31^−1/2 ≈ 0.18) |
| 🟢 CG | come i CGL, ~16% più basso | ≈ 0.67 | ✅ **sì** | stessa velocità dei CGL (rette parallele) |

✔️ Grado 2: equispaziati e CGL coincidono (nodi −5, 0, 5) → stesso errore 0.646.
✔️ Tabella gradi 2–14 uguale alla slide 14 entro l'1.3% (diversa griglia per il massimo).

---

## 💡 Note e trucchi importanti

- 🔢 **Grado k ⇒ k + 1 nodi**: per questo negli script c'è sempre `chebgausslob(a, b, k + 1)`.
- ➖ **Segno meno davanti al coseno** (come nella slide 7): stessi nodi delle slide, ma in ordine crescente.
- 📏 **Vettori colonna ovunque**: `interpol` fa `x(:)`, `y(:)`, `s(:)`, così non ci sono problemi di dimensioni.
- 🔇 **Warning di polyfit spento** in `script_convergenza` (`MATLAB:polyfit:RepeatedPointsOrRescale`): ai gradi alti la Vandermonde è mal condizionata. Il warning viene riacceso subito dopo il ciclo e gli errori restano regolari fino al grado 31.
- 🖨️ **Stampa doppia** con `for out = [1 fid]`: 1 = Command Window, `fid` = file `.txt`. Una sola riga di `fprintf` scrive in tutti e due.
- 0️⃣ `-0.0000` nelle tabelle = zero di macchina (cos(π/2) ≈ 6e−17), non è un errore.
- 🔢 Numeri di figura tutti diversi (1–8), così gli script non si sovrascrivono le figure.

---

## 🖼️ Figure

| Figura | Script | Cosa mostra |
|---|---|---|
| 1️⃣ | `script_nodi` | Nodi CG in [−1, 1], m = 10 e 20 |
| 2️⃣ | `script_nodi` | Nodi CGL in [−1, 1], m = 10 e 20 |
| 3️⃣ | `script_nodi` | Interpretazione geometrica dei CGL (semicirconferenza) |
| 4️⃣ | `script_confronto` | Confronto CG / CGL, n = 5 |
| 5️⃣ | `script_confronto` | Confronto CG / CGL, n = 35 |
| 6️⃣ | `script_runge` | Runge + interpolanti di grado 12 (equisp. e CGL) |
| 7️⃣ | `script_runge` | Errore puntuale \|f − p₁₂\| |
| 8️⃣ | `script_convergenza` | Errore vs grado in semilogy (equisp., CGL, CG) |

---

## 🏁 Conclusioni in breve

- 🎯 La **scelta dei nodi è decisiva**: stessi dati, stesso costo, risultati opposti.
- 🔴 **Equispaziati**: con la funzione di Runge l'errore cresce in modo esponenziale → niente convergenza.
- 🔵🟢 **Chebyshev (CG e CGL)**: l'errore cala in modo esponenziale → convergenza uniforme, come dice Bernstein.
- ⚖️ CG leggermente meglio dei CGL, ma stessa velocità.
- ⚠️ Per gradi molto alti `polyfit` diventa mal condizionato: fino a 31 va bene, oltre servono altri metodi.

---

✨ Fine! 🎉