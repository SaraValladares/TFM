# Código TFM Sara V.

Código generado para el TFM de Sara Valladares Aguirre en el Máster de bioinformática y biología computacional de la Universidad Autónoma de Madrid (UAM)
El código está dividido en dos carpetas. En una de ellas esta el código implementado para bash y la otra para el código usado en el lenguaje de programación R.

El objetivo del trabajo y del código generado es analizar los datos de un RNA-seq realizado en muestras recogidas en distintos tiempos y condiciones de la planta Arabidopsis thaliana. 

## Carpeta "bash"
En esta carpeta encontramos el archivo quality_aligment_counts.sh que contiene el código generado en bash para realizar:
    Análisis de calidad
    Filtrado de secuencias
    Alineamiento contra el genoma de referencia
    Cuantificación de tránscritos

## Carpeta "R"
En esta carpeta se encuentra el código denerado en el lenguage de programación R en extensión .qmd. Esta extensión permite su mejor visualización y la posibilidad de convertir el código a HTML.
    Analisis previo de los datos: PCA, correlación de Pearson, detección de muestras atípicas
    Analisis de expresión diferencial: DESeq2
    Agrupamiento por HC kmeans
    Analisis de enriquecimiento por GO
    Analisis con matriz de distancias de Mahalanobis

En la carpeta encontramos también el archivo WGCNA.qmd en el que se ha reslizado un analisis de co-expresión génica usando la herramienta WGCNA.