
#!/bin/bash
# Instalamos FastQC
conda install -c bioconda fastqc


# Queremos ver la calidad de los reads que tenemos, por lo que analizamod los fastqc:
# Creamos un en el que tendremos los archivos de la calidad previa de las secuencias.
mkdir calidad_previa

# Corremos la herramienta en todas nuestras muestras y guardamos nuestros resultados en nuestra carpeta creada
fastqc *.fastq.gz -o calidad_previa/ # en nuestro caso los archivos se encontraban comprimidos.

# Trim Galore!
conda install -c bioconda trim-galore

mkdir calidad_posterior

# usamos trim galore para muestras pair end, pedimos que la calidad mínima sea de 20:

#  trim_galore --paired --quality 20 --fastqc sample_R1.fastq.gz sample_R2.fastq.gz

for file in *_1.fastq; do
    base=$(basename "$file" _1.fastq)
    trim_galore --paired --quality 20 --fastqc --output_dir calidad_posterior "${base}_1.fastq" "${base}_2.fastq"
done

# HISAT2: alineamento de secuencias.
conda install -c bioconda hisat2


# Corremos la herramienta:
cd home/sara/calidad_posterior 

hisat2-build TAIR10.fasta indice_Athaliana

for file in *_1_val_1.fq; do
    base=$(basename "$file" _1_val_1.fq)
    hisat2 -x indice_Athaliana -1 "${base}_1_val_1.fq" -2 "${base}_2_val_2.fq.gz" -S "${base}.sam" --threads 4
done


# Pasamos los archivos de SAM a BAM y guardamos en una carpeta nueva
conda install -y -c bioconda samtools

mkdir -p bam_files

for samfile in *.sam; do
    base=$(basename "$samfile" .sam)
    samtools view -bS "$samfile" | samtools sort -o "bam_files/${base}.sorted.bam"
    
done

# Conseguimos el conteo de los genes con htseq

conda install -y -c bioconda htseq

mkdir -p counts

for bamfile in bam_files/*.sorted.bam; do
    base=$(basename "$bamfile" .sorted.bam)
    
    htseq-count -f bam -r pos -s reverse -t exon -i gene_id "$bamfile" Athaliana.gtf > "counts/${base}_counts.txt"
done