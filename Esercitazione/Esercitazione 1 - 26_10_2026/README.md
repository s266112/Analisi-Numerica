# 🧮 Esercitazione 1 – Analisi Numerica

> 🎯 **Obiettivo:** risolvere equazioni non lineari con **Punto Fisso**, **Secanti variabili** e **Steffensen**, e applicarli all'equazione di **Colebrook-White**.

---

## 📁 Struttura del progetto

```
📦 Esercitazione1/
 ┣ 🔧 pfisso.m                  → metodo di punto fisso
 ┣ 🔧 secvariabile.m            → metodo delle secanti variabili
 ┣ 🔧 steffensen.m              → metodo di Steffensen
 ┣ ▶️ script_steffensen.m       → test di Steffensen su f(x) = x·eˣ − 1
 ┣ ▶️ script_colebrook.m        → risoluzione di Colebrook-White con i 3 metodi
 ┣ 📄 risultati_colebrook.txt   → output generato (radici, iterazioni, scarti)
 ┣ 📄 stima_convergenza.txt     → output generato (p, C, errore finale)
 ┣ 📝 Relazione.docx / .pdf     → relazione finale
 ┗ 📘 README.md                 → questo file 😄
```

---

## 🚀 Come si esegue

1. 📂 Apri MATLAB e imposta come **Current Folder** la cartella del progetto.
2. ▶️ Lancia i due script dalla Command Window:

```matlab
clear
script_colebrook     % apre le figure 1, 2, 3 e scrive i due file .txt
script_steffensen    % apre le figure 4, 5
```

3. 🖼️ Alla fine devi avere **5 figure** aperte e **2 file .txt** aggiornati nella cartella.

---

## 🔧 Le function

| Function | Chiamata | Output |
|---|---|---|
| 🔁 Punto fisso | `[xvec, iter, scarti] = pfisso(g, x0, toll, maxit)` | ⚠️ `iter` è il **secondo** output |
| 📐 Secanti | `[xvec, scarti, iter] = secvariabile(f, x0, toll, itmax)` | se `x0` è scalare, il 2° punto è `x0 + 0.01` |
| ⚡ Steffensen | `[xv, scartiv, iter] = steffensen(f, x0, toll, nmax)` | si ferma anche se `f(x) == 0` o `g(x) == 0` |

🛑 **Test d'arresto** (uguale per tutti): scarto assoluto `|x_{k+1} − x_k| ≤ toll`, oppure numero massimo di iterazioni raggiunto (con messaggio di avviso).

### ⚡ Formula di Steffensen

$$
x_{n+1} = x_n - \frac{f(x_n)}{g(x_n)}, \qquad g(x_n) = \frac{f\big(x_n + f(x_n)\big) - f(x_n)}{f(x_n)}
$$

👉 È Newton senza derivata: `f'(x)` è sostituita da un rapporto incrementale con passo `h = f(x_n)`.

---

## 🧪 Test di Steffensen – `f(x) = x·eˣ − 1`

⚙️ Parametri: `x0 = 0.5`, `toll = 1e-10`, `nmax = 50`

| Risultato | Valore |
|---|---|
| 🎯 Radice | `0.567143290409784` |
| 🔢 Iterazioni | `5` |
| 📈 Ordine p | `1.9999` ✅ (teorico 2) |
| 📏 Costante C | `3.0773` ✅ (teorico ≈ 3.08) |

💡 **Trucco importante:** l'ultima iterata coincide con la radice di `fzero` → errore = 0 → `log(0)` → `p = Inf` ❌.
Soluzione: uso solo gli errori **non nulli** → `ez = e(e > 0);` ✅

---

## 🌊 Colebrook-White

$$
\frac{1}{\sqrt{x}} = -2\log_{10}\left(\frac{e}{3.51\,d} + \frac{2.52}{N_R\sqrt{x}}\right)
$$

⚙️ Caso test: `e = 1e-2`, `d = 0.20`, `NR = 1e4`, `TOL = 1e-7`, `nmax = 100`

### 🧩 Funzioni usate

- 🔵 **f(x)** per secanti e Steffensen:
  `f = @(x) 1./sqrt(x) + 2*log10(A + B./sqrt(x))` con `A = e/(3.51*d)`, `B = 2.52/NR`
- 🟣 **g(x)** per il punto fisso:
  `g = @(x) 1./(4*(log10(A + B./sqrt(x))).^2)`

### 🛠️ Come ho ricavato g(x)

1. Isolo la radice: `1/√x = −2·log10(…)`
2. Inverto: `√x = 1 / (−2·log10(…))`
3. Elevo al quadrato: `x = 1 / (4·log10(…)²) = g(x)` ✅
4. Convergenza garantita: `|g'(α)| ≈ 0.0144 < 1` 🎉 (segno negativo → iterate che **oscillano** attorno ad α)

### 📊 Risultati

| Metodo | x0 | Radice | Iter. | Ultimo scarto |
|---|---|---|---|---|
| 🔁 Punto Fisso | 0.07 | `0.07553655368855` | 4 | `1.7867e-08` |
| 📐 Secanti | 0.07 | `0.07553655394566` | 4 | `2.6405e-08` |
| ⚡ Steffensen | 0.0755 | `0.07553655394282` | 3 | `2.2442e-11` |

### 📈 Ordine e costante asintotica

| Metodo | p stimato | p teorico | C stimata | C teorica | Errore finale |
|---|---|---|---|---|---|
| 🔁 Punto Fisso | 1.0000 | 1 ✅ | 0.0144 | \|g'(α)\| = 0.0144 ✅ | `2.5427e-10` |
| 📐 Secanti | 1.5188 | 1.618 🟡 | 0.9187 | non confrontabile | `2.8390e-12` |
| ⚡ Steffensen | 1.9999 | 2 ✅ | 232.2 | ≈ 232.6 ✅ | `1.3878e-17` |

🧮 **Formule usate** (con `e_k = |x_k − α|`, α calcolata con `fzero`):

$$
p \approx \frac{\log(e_{k+1}/e_k)}{\log(e_k/e_{k-1})}, \qquad C \approx \frac{e_{k+1}}{e_k^{\,p}}
$$

🔍 **Formula della C teorica di Steffensen:**

$$
C = \left|\frac{f''(\alpha)}{2f'(\alpha)}\big(1 + f'(\alpha)\big)\right|
$$

🟡 **Secanti:** p non arriva a 1.618 perché ci sono poche iterazioni e il regime asintotico non viene raggiunto.
⚡ **Steffensen:** per stimare p uso gli errori delle **prime** iterazioni, perché l'ultimo errore è già alla precisione di macchina.

---

## ⚠️ Attenzione: Steffensen è delicato!

😬 Steffensen valuta f nel punto **ausiliario** `x + f(x)`. Se x0 è lontano dalla radice, il punto ausiliario finisce lontano:

| x0 | f(x0) | x0 + f(x0) | Risultato |
|---|---|---|---|
| 0.07 | ≈ 0.14 | ≈ 0.21 | ❌ diverge |
| 0.074 | ≈ 0.038 | ≈ 0.112 | ✅ converge |
| 0.0755 | ≈ 0.0009 | ≈ 0.0764 | ✅✅ 3 iterazioni |
| 0.076 | ≈ −0.011 | ≈ 0.065 | ✅ converge |
| 0.08 | ≈ −0.10 | **< 0** 💥 | ❌ √x non definita |

👉 Funziona solo per **x0 ∈ [0.074, 0.076]** circa.

---

## 🖼️ Figure

| # | Script | Contenuto |
|---|---|---|
| 1️⃣ | `script_colebrook` | 📉 Localizzazione dello zero (con `ylim([-1.6 7])`) |
| 2️⃣ | `script_colebrook` | 🔀 g(x) e bisettrice y = x |
| 3️⃣ | `script_colebrook` | 📊 Profili di convergenza dei 3 metodi (semilogy) |
| 4️⃣ | `script_steffensen` | 📈 Grafico di x·eˣ − 1 |
| 5️⃣ | `script_steffensen` | 📊 Convergenza di Steffensen sul test |

---

## 🏁 Conclusioni (in breve)

- ⚡ **Steffensen**: il più veloce (convergenza quadratica), ma serve un x0 vicinissimo alla radice e fa 2 valutazioni di f per iterazione.
- 📐 **Secanti**: il compromesso migliore, superlineare, 1 valutazione di f per iterazione e robusto.
- 🔁 **Punto fisso**: il più semplice e lineare, ma qui veloce lo stesso perché C è piccolissima.

---

## 🌿 Git – comandi veloci

```matlab
!git status
!git add .
!git commit -m "Esercitazione 1 completata 🎉"
!git push
```

---

✨ *Fatto con tanta pazienza e qualche `NaN` di troppo* 😅