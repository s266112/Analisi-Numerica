# 🧮 Laboratorio 5 — Matrici in MATLAB

> 📚 Corso di **Analisi Numerica** — Laurea Triennale in Intelligenza Artificiale e Data Analytics, Università di Trieste (A.A. 2026–2027)

In questo laboratorio si impara a lavorare con le **matrici**, la struttura di base di MATLAB: come definirle, leggerne e modificarne gli elementi, estrarne righe, colonne, **diagonali** e parti **triangolari**, e fare le operazioni tra matrici. Alla fine si risolve un **sistema lineare** con `A\b` e si vede cosa succede quando una matrice è **singolare**.

---

## 📂 Struttura della cartella

| File | Tipo | Descrizione |
|---|---|---|
| `script_matrici_base.m` | 📜 script | Esempi (slide 2, 4, 5): definizione, accesso agli elementi, estrazione di righe, colonne e sottomatrici, allargamento automatico |
| `script_operazioni.m` | 📜 script | Esempi (slide 6, 8, 9): comandi che generano matrici, `size`, `det`, `inv`, `eig`, operazioni tra matrici |
| `script_diagonali.m` | 📜 script | Esempi (slide 10–13): `diag`, `tril`, `triu`, costruzione di matrici diagonali |
| `script_sistema.m` | 📜 script | Esempio (slide 14): sistema lineare con `A\b`, confronto con `inv(A)*b` |
| `script_esercizio1.m` | 📜 script | Esercizio (slide 3): matrice 2×3 con i numeri da 1 a 6, azzerare A(1,1) e A(2,2) |
| `script_esercizio2.m` | 📜 script | Esercizio (slide 6–7): determinante e inversa di `ones(4)` |

> ℹ️ In questo laboratorio non ci sono function da scrivere né grafici: si usano i comandi di MATLAB per le matrici, e i risultati sono riportati in tabella.

---

## 🧠 Un minimo di teoria

### 🔲 Tutto è una matrice
In MATLAB ogni variabile è una matrice: uno **scalare** è 1×1, un **vettore riga** è 1×n, un **vettore colonna** è n×1. Una matrice si scrive riga per riga: lo spazio separa gli elementi, il punto e virgola separa le righe.

```matlab
A = [1 2 3; 4 5 6; 7 8 9];
```

⚠️ MATLAB memorizza le matrici **per colonne**: per questo `reshape` riempie la matrice colonna per colonna.

### ✖️ Due prodotti diversi
- **Prodotto riga per colonna** `A*B`: si può fare se le colonne di A sono quante le righe di B, e

$$
c_{ij} = \sum_k a_{ik}\, b_{kj}
$$

- **Prodotto componente a componente** `A.*B`: richiede matrici della stessa dimensione, e $c_{ij} = a_{ij}\, b_{ij}$.

### 🔺 Diagonali e scomposizione $A = L + D + U$
Con `tril`, `triu` e `diag` ogni matrice quadrata si scompone in parte strettamente triangolare inferiore, diagonale e strettamente triangolare superiore:

$$
A = \underbrace{\text{tril}(A,-1)}_{L} + \underbrace{\text{diag}(\text{diag}(A))}_{D} + \underbrace{\text{triu}(A,1)}_{U}
$$

Questa scomposizione servirà più avanti per i metodi iterativi (Jacobi, Gauss-Seidel).

### 🧩 Sistemi lineari e matrici singolari
Il sistema $A\mathbf{x} = \mathbf{b}$ si risolve con `x = A\b`: se A è quadrata e invertibile, MATLAB usa l'**eliminazione di Gauss con pivoting**, senza calcolare $A^{-1}$. Questo costa meno e garantisce un **residuo** $\lVert \mathbf{b} - A\mathbf{x} \rVert$ dell'ordine della precisione di macchina.

Se $\det(A) = 0$ la matrice è **singolare**: le righe sono linearmente dipendenti, l'inversa non esiste e il sistema non ha soluzione unica. Il determinante è il prodotto degli autovalori, quindi una matrice singolare ha almeno un autovalore nullo.

---

## ⚙️ Comandi MATLAB usati

| Comando | Cosa fa |
|---|---|
| `A(i,j)` | elemento in riga `i` e colonna `j` |
| `A(i,:)`, `A(:,j)` | riga `i`, colonna `j` |
| `A(r1:r2, c1:c2)` | sottomatrice |
| `rand(m,n)`, `eye(n)`, `ones(n)`, `zeros(n)` | matrice casuale, identità, di uni, di zeri |
| `[nr, nc] = size(A)` | numero di righe e di colonne |
| `det(A)`, `inv(A)`, `eig(A)` | determinante, inversa, autovalori |
| `A'` | trasposta |
| `A*B`, `A.*B` | prodotto riga per colonna, prodotto componente a componente |
| `diag(A,k)` | diagonale `k` di A, come vettore colonna |
| `diag(v,k)` | matrice con il vettore `v` sulla diagonale `k` |
| `tril(A,k)`, `triu(A,k)` | parte triangolare inferiore, superiore |
| `x = A\b` | soluzione del sistema lineare $A\mathbf{x} = \mathbf{b}$ |
| `rank(A)`, `rcond(A)` | rango, stima di quanto A è vicina a essere singolare (≈ 1 buona, ≈ 0 singolare) |
| `reshape(v,m,n)` | dispone gli elementi di `v` in una matrice m×n, per colonne |

---

## 📝 Esempi

### 1️⃣ Definizione ed estrazione di parti di una matrice — `script_matrici_base.m`

🎯 Definire una matrice, accedere a un elemento, estrarre righe, colonne e sottomatrici, e vedere come MATLAB allarga una matrice quando si assegna un elemento fuori dalle sue dimensioni. *(slide 2, 4, 5)*

Matrice delle slide 4 e 5:

$$
A = \begin{pmatrix} 1 & 1 & 1 \\ -2 & 3 & 1 \\ 4 & -6 & 7 \end{pmatrix}
$$

📊 **Risultati:**

| Comando | Risultato | Dimensione |
|---|---|---|
| `A1(2,3)` con `A1 = [1 2 3; 4 5 6; 7 8 9]` | `6` | 1×1 |
| `A(2,:)` | `-2  3  1` | 1×3 (riga) |
| `A(:,3)` | `1; 1; 7` | 3×1 (colonna) |
| `A(2:3,:)` | `-2 3 1` / `4 -6 7` | 2×3 |
| `B(5,5) = 2` | B diventa 5×5, nuove righe e colonne a zero | 5×5 |
| `B(3,6) = 9` (su B 3×3) | crescono solo le colonne, `9` in posizione (3,6) | 3×6 |

💡 **Lezione.** L'estrazione conserva l'orientamento: una riga resta un vettore riga, una colonna un vettore colonna. Assegnando un elemento fuori dalle dimensioni, MATLAB **allarga** la matrice e riempie con zeri senza dare errore: è comodo, ma un indice sbagliato può creare una matrice più grande senza che ce ne accorgiamo.

---

### 2️⃣ Comandi predefiniti e operazioni tra matrici — `script_operazioni.m`

🎯 Usare i comandi che generano matrici e quelli che calcolano dimensioni, determinante, inversa e autovalori; fare somma, sottrazione, trasposta, prodotto per scalare, prodotto riga per colonna e prodotto componente a componente. *(slide 6, 8, 9)*

Matrici della slide 9:

$$
A = \begin{pmatrix} 4 & -1 & 0 \\ -1 & 4 & -1 \\ 0 & -1 & 4 \end{pmatrix}, \qquad
B = \begin{pmatrix} 1 & 2 & 3 \\ -4 & -5 & -6 \\ 0 & 1 & 2 \end{pmatrix}
$$

> ℹ️ La slide 6 non dà dati per `det`, `inv` ed `eig`: li ho calcolati sulla A della slide 9. Per `rand` il generatore è fissato con `rng(0)`, e per `s*A` ho scelto `s = 2`.

📊 **Risultati — comandi su A:**

| Comando | Risultato |
|---|---|
| `rand(2,3)` con `rng(0)` | `0.8147 0.1270 0.6324` / `0.9058 0.9134 0.0975` |
| `size(A)` | 3 righe, 3 colonne |
| `det(A)` | `56` |
| `inv(A)` | `0.2679 0.0714 0.0179` / `0.0714 0.2857 0.0714` / `0.0179 0.0714 0.2679` |
| `eig(A)` | `2.5858`, `4.0000`, `5.4142` |

📊 **Risultati — operazioni:**

| Operazione | Risultato |
|---|---|
| `2*A8` con `A8 = [2 -1; 3 4; -2 7]` | `4 -2` / `6 8` / `-4 14` |
| `A8'` | `2 3 -2` / `-1 4 7` (da 3×2 a 2×3) |
| `A + B` | `5 1 3` / `-5 -1 -7` / `0 0 6` |
| `A - B` | `3 -3 -3` / `3 9 5` / `0 -2 2` |
| `A * B` | `8 13 18` / `-17 -23 -29` / `4 9 14` |
| `A .* B` | `4 -2 0` / `4 -20 6` / `0 -1 8` |

💡 **Lezione.**
- Gli autovalori di A sono $4-\sqrt2$, $4$, $4+\sqrt2$: reali, perché A è simmetrica, e tutti positivi. Il loro prodotto è $(16-2) \cdot 4 = 56 = \det(A)$.
- Anche l'inversa di una matrice simmetrica è simmetrica, come si vede in `inv(A)`.
- `A*B` e `A.*B` sono operazioni diverse. In posizione (2,2): `A*B` dà $(-1)(2) + 4(-5) + (-1)(1) = -23$ (riga per colonna), mentre `A.*B` dà $4 \cdot (-5) = -20$ (solo i due elementi in quella posizione).

---

### 3️⃣ Diagonali e parti triangolari — `script_diagonali.m`

🎯 Estrarre diagonali con `diag`, parti triangolari con `tril` e `triu`, e costruire matrici diagonali a partire da un vettore o dalla diagonale di una matrice. *(slide 10–13)*

Matrice delle slide 10, 11, 13:

$$
A = \begin{pmatrix} 1 & 2 & 3 & 4 \\ 2 & 3 & 5 & 7 \\ 3 & 3 & 4 & 8 \\ 0 & -1 & 2 & 3 \end{pmatrix}
$$

📊 **Risultati:**

| Comando | Risultato | Slide |
|---|---|---|
| `diag(A)` | `1; 3; 4; 3` | 10 |
| `diag(A,-1)` | `2; 3; 2` | 10 |
| `diag(A,2)` | `3; 7` | 10 |
| `tril(A)` | `1 0 0 0` / `2 3 0 0` / `3 3 4 0` / `0 -1 2 3` | 11 |
| `tril(A,-1)` | `0 0 0 0` / `2 0 0 0` / `3 3 0 0` / `0 -1 2 0` | 11 |
| `triu(A)` | `1 2 3 4` / `0 3 5 7` / `0 0 4 8` / `0 0 0 3` | 11 |
| `diag([-1 -2 5 9])` | 4×4 con `-1, -2, 5, 9` sulla diagonale | 12 |
| `diag([-1 -2 -3], -1)` | **4×4** con `-1, -2, -3` sotto la diagonale | 12 |
| `diag(diag(A))` | 4×4 con `1, 3, 4, 3` sulla diagonale | 13 |

💡 **Lezione.**
- Lo stesso comando `diag` fa due cose opposte: su una **matrice** estrae una diagonale (come vettore colonna), su un **vettore** costruisce una matrice.
- La diagonale $k$ di una matrice $n \times n$ ha $n - \lvert k \rvert$ elementi; viceversa, `diag(w,k)` costruisce una matrice di ordine `length(w) + abs(k)`. Per questo `diag(w,-1)` con 3 elementi è 4×4.
- `tril(A,-1)`, `diag(diag(A))` e `triu(A,1)` sono i tre pezzi della scomposizione $A = L + D + U$.

> ℹ️ Nelle slide 12–13 compare la scritta `Diagonal Matrix`: è un'aggiunta di Octave, MATLAB non la stampa.

---

### 4️⃣ Soluzione di un sistema lineare — `script_sistema.m`

🎯 Risolvere $A\mathbf{x} = \mathbf{b}$ con il comando `A\b`. *(slide 14)*

$$
A = \begin{pmatrix} 10 & -7 & 0 \\ -3 & 2 & 6 \\ 5 & -1 & 5 \end{pmatrix}, \qquad
\mathbf{b} = \begin{pmatrix} 7 \\ 4 \\ 6 \end{pmatrix}
$$

> ℹ️ Il confronto con `inv(A)*b` e il calcolo del residuo non sono nel PDF: li ho aggiunti per vedere perché si preferisce `A\b`.

📊 **Risultati:**

| k | x con `A\b` | x con `inv(A)*b` |
|---|---|---|
| 1 | 2.664535259100376e-16 | 0.000000000000000e+00 |
| 2 | -9.999999999999997e-01 | -1.000000000000000e+00 |
| 3 | 9.999999999999999e-01 | 9.999999999999999e-01 |

| Metodo | Norma del residuo $\lVert \mathbf{b} - A\mathbf{x} \rVert$ |
|---|---|
| `A\b` | 8.88e-16 |
| `inv(A)*b` | 1.26e-15 |

💡 **Lezione.** Entrambi i metodi danno la soluzione della slide 14, $\mathbf{x} = (0, -1, 1)$, con errori dell'ordine della precisione di macchina (`eps` ≈ 2.2e-16). Che uno dei due esca con lo 0 "tondo" in prima componente è un caso: dipende dall'ordine degli arrotondamenti. Conta invece il **residuo**, che con `A\b` è più piccolo (8.9e-16 contro 1.3e-15): Gauss con pivoting garantisce un residuo dell'ordine di `eps`, l'inversa no.

Su un sistema piccolo e ben condizionato le due strade sono quindi equivalenti fino alla sedicesima cifra. Ma `A\b` **costa meno** (non calcola $A^{-1}$) ed è **più affidabile** sul residuo, e i vantaggi crescono per matrici grandi o mal condizionate: in MATLAB si scrive sempre `A\b`, mai `inv(A)*b`.

---

## 📝 Esercizi

### 5️⃣ Esercizio della slide 3 — `script_esercizio1.m`

> 🎯 **Esercizio.** Costruire una matrice 2 × 3 con i primi sei numeri interi come coefficienti. Azzerare gli elementi A(1,1) e A(2,2). *(slide 3)*

📊 **Risultati:**

| Passo | Risultato |
|---|---|
| `A = [1 2 3; 4 5 6]` | `1 2 3` / `4 5 6` |
| `reshape(1:6, 3, 2)'` | `1 2 3` / `4 5 6` |
| `isequal` tra le due | `1` (uguali) |
| `A(1,1) = 0; A(2,2) = 0;` | `0 2 3` / `4 0 6` |

💡 **Lezione.** La matrice si può scrivere a mano riga per riga, oppure costruire con `reshape`. Siccome `reshape` riempie **per colonne**, bisogna creare una 3×2 e trasporla; senza trasposta `reshape(1:6, 2, 3)` darebbe `1 3 5` / `2 4 6`. Assegnando `A(i,j) = 0` si modifica solo l'elemento indicato: gli altri e le dimensioni restano invariati.

---

### 6️⃣ Esercizio della slide 6 — `script_esercizio2.m`

> ❓ **Domanda.** Creare una matrice quadrata A di ordine 4 con tutti gli elementi uguali a 1 e calcolarne il determinante. Che cosa succede se proviamo a calcolare l'inversa di A? *(slide 6, soluzione slide 7)*

📊 **Risultati:**

| Comando | Risultato |
|---|---|
| `det(A)` | `0` |
| `rank(A)` | `1` (su 4 righe) |
| `rcond(A)` | `0` |
| `eig(A)` | `-6.33e-16`, `0`, `7.79e-17`, `3.999999999999999` |
| `inv(A)` | `Warning: Matrix is singular to working precision.` e matrice 4×4 di `Inf` |

> ℹ️ `rank`, `rcond` ed `eig` non sono richiesti dal PDF: li ho aggiunti per spiegare *perché* l'inversa non esiste.

💬 **Risposta.** Le 4 righe di `ones(4)` sono tutte uguali, quindi linearmente dipendenti: il rango è 1, il determinante è 0 e la matrice è **singolare**. L'inversa **non esiste**. MATLAB prova comunque a calcolarla con la fattorizzazione LU: dopo il primo passo di eliminazione tutte le altre righe diventano zero, trova un pivot nullo e dividendo per zero ottiene `Inf`. Il risultato è il warning e una matrice piena di `Inf`, che non ha alcun significato e non va usata.

Gli autovalori teorici sono $0, 0, 0, 4$: l'autovalore 4 corrisponde al vettore $(1,1,1,1)^T$, perché $A\,(1,1,1,1)^T = 4\,(1,1,1,1)^T$. Numericamente gli zeri escono come numeri dell'ordine di `eps`. `det` invece dà 0 esatto, perché l'eliminazione fa solo sottrazioni $1 - 1$, senza arrotondamenti.

💡 **Lezione.** Prima di invertire una matrice o risolvere un sistema conviene controllare che non sia (quasi) singolare con `rcond`, non con `det(A) == 0`. Per una matrice quasi singolare il determinante può essere piccolissimo senza essere zero, e il suo valore dipende anche dalla scala della matrice.

> ℹ️ Nella slide 7 il warning è quello di Octave (`warning: inverse: matrix singular to machine precision, rcond = 0`); MATLAB scrive `Warning: Matrix is singular to working precision.`

---

## 🎯 Concetti chiave da ricordare

- 🔲 In MATLAB tutto è una matrice, memorizzata **per colonne**; `A(i,j)`, `A(i,:)`, `A(:,j)` leggono e scrivono elementi, righe e colonne.
- 📏 Assegnare un elemento fuori dalle dimensioni **allarga** la matrice e riempie con zeri, senza dare errore.
- ✖️ `A*B` (riga per colonna) e `A.*B` (elemento per elemento) sono operazioni diverse.
- 🔺 `diag` estrae una diagonale da una matrice o costruisce una matrice da un vettore; con `tril` e `triu` si ottiene la scomposizione $A = L + D + U$.
- 🧩 I sistemi lineari si risolvono con `A\b` (Gauss con pivoting): costa meno di `inv(A)*b` e garantisce un residuo dell'ordine di `eps`.
- 🚫 Una matrice con righe dipendenti è **singolare**: determinante zero, almeno un autovalore nullo, nessuna inversa. MATLAB dà solo un warning e restituisce `Inf`: per riconoscere una matrice (quasi) singolare si usa `rcond`.

---

## ▶️ Come eseguire

1. Apri MATLAB e imposta questa cartella come **Current Folder**
2. Lancia uno script dalla Command Window, ad esempio:

```matlab
>> script_matrici_base
>> script_operazioni
>> script_diagonali
>> script_sistema
>> script_esercizio1
>> script_esercizio2
```

Ogni script stampa i risultati in colonne nella Command Window 📊. Gli script sono divisi in sezioni `%%`: si può eseguire una sezione alla volta con **Run Section** (Ctrl+Invio), dopo aver eseguito la sezione dei parametri di input.