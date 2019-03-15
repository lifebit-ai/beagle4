#!/bin/bash

if [ ! -f bref.11Mar19.69c.jar ]; then
  echo
  echo "Downloading bref.11Mar19.69c.jar"
  wget http://faculty.washington.edu/browning/beagle/bref.11Mar19.69c.jar
fi

echo

if [ ! -f test.11Mar19.69c.vcf.gz ]; then
    echo
    echo "*** Downloading some 1000 Genomes Project data to file: test.11Mar19.69c.vcf.gz ***"
    wget http://faculty.washington.edu/browning/beagle/test.11Mar19.69c.vcf.gz
fi

echo
echo "*** Creating test files: ref.11Mar19.69c.vcf.gz target.11Mar19.69c.vcf.gz ***"
echo
zcat test.11Mar19.69c.vcf.gz | cut -f1-190 | tr '/' '|' | gzip > ref.11Mar19.69c.vcf.gz
zcat test.11Mar19.69c.vcf.gz | cut -f1-9,191-200 | gzip > target.11Mar19.69c.vcf.gz


echo
echo "*** Running test analysis with \"gt=\" argument ***"
echo
beagle gt=test.11Mar19.69c.vcf.gz out=out.gt

echo
echo "*** Running test analysis with \"gl=\" argument ***"
echo
beagle gl=test.11Mar19.69c.vcf.gz out=out.gl

echo
echo "*** Running test analysis with \"ref=\" argument ***"
echo
beagle ref=ref.11Mar19.69c.vcf.gz gt=target.11Mar19.69c.vcf.gz out=out.ref

echo
echo "*** Making \"bref\" file ***"
echo
java -jar bref.11Mar19.69c.jar ref.11Mar19.69c.vcf.gz

echo
echo "*** Running test analysis with \"bref=\" argument ***"
echo
beagle ref=ref.11Mar19.69c.bref gt=target.11Mar19.69c.vcf.gz out=out.bref

