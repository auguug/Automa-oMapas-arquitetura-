# Gerador de Mapas

Aplicativo desktop para Windows que gera, com poucos cliques, mapas de **localização**, mapas de **curvas de nível** e relatórios de **conforto térmico**, prontos para laudos e relatórios técnicos (PNG e PDF em 300 ou 600 DPI).

Não exige conhecimento de programação: a interface é uma janela simples e o programa instala as próprias dependências na primeira execução.

## O que ele faz

| Aba | Resultado |
|---|---|
| **Localização** | Mapa América do Sul → UF → município, com relevo e legenda de fonte. |
| **Curvas de Nível** | Imagem de satélite com curvas de nível e contorno do terreno, a partir de um KML. Opção de folha A4. |
| **Conforto Térmico** | 20 gráficos de clima e conforto (ITU, mapas de calor, rosa dos ventos, radiação, previsão de 16 dias etc.), relatório em PDF e dados em CSV. |

## Instalação

**Requisito:** [Python 3.12](https://www.python.org/downloads/windows/) com a opção **Add python.exe to PATH** marcada.

1. Baixe ou clone este repositório numa pasta fixa (ex.: `Documentos\GeradorMapas`).
2. Dê dois cliques em `INSTALAR.bat`. Ele cria o ambiente virtual, instala as bibliotecas e coloca o atalho **Gerador de Mapas** na Área de Trabalho.

Se preferir, pule o passo 2 e abra `ABRIR GERADOR.bat`: o programa se instala sozinho na primeira vez.

## Como usar

Abra o atalho (ou `ABRIR GERADOR.bat`), escolha a aba, preencha os campos e clique em **Gerar mapa**. Os arquivos vão para `Documentos\Mapas Gerados` (ou a pasta escolhida em "Salvar em"), que abre ao terminar.

O passo a passo de cada aba está no **[Manual de Uso](Manual/Manual%20de%20Uso.html)** (abra o arquivo no navegador).

### Linha de comando

```bash
.venv\Scripts\python app\mapa_localizacao.py --municipio "Campo Mourao" --uf PR --fonte "Autor (2026)" --dpi 600
```

## Estrutura do projeto

```
├─ ABRIR GERADOR.bat       abre o programa
├─ INSTALAR.bat            instalação inicial e atalho
├─ Manual/                 manual de uso (HTML)
├─ app/
│  ├─ gerador_mapas.pyw    interface (Tkinter)
│  ├─ mapa_localizacao.py  mapa de localização
│  ├─ mapa_curvas.py       mapa de curvas de nível
│  ├─ conforto_termico.py  gráficos de conforto térmico
│  └─ requirements.txt
└─ logs/                   registro da instalação
```

## Tecnologias

Python, Tkinter, GeoPandas, Rasterio, Shapely, Matplotlib, Contextily e tkintermapview.

## Fontes de dados

- **Malhas municipais e estaduais:** IBGE, malha territorial 2024 (SIRGAS 2000, EPSG:4674)
- **Países:** Natural Earth 1:50m
- **Relevo:** Copernicus DEM GLO-30 (30 m)
- **Imagem de satélite:** Esri World Imagery
- **Clima:** Open-Meteo (gratuito, sem cadastro; histórico com cerca de 5 dias de atraso)
- **Busca de lugares:** Open-Meteo Geocoding e Nominatim (OpenStreetMap)

## Limitações

- Precisa de internet para baixar dados de municípios novos, imagens de satélite e clima.
- O relevo de 30 m não registra detalhes menores que cerca de 30 m. As curvas de nível geradas mostram a tendência do terreno e **não substituem levantamento topográfico**.
