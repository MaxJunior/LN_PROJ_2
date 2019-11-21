#!/bin/bash



#################  compiling all transducers from a)  ################ 
fstcompile --isymbols=syms.txt --osymbols=syms.txt lemma2verbif.txt  > FINALtransducers/lemma2verbif.fst 
fstcompile --isymbols=syms.txt --osymbols=syms.txt lemma2verbis.txt  > FINALtransducers/lemma2verbis.fst
fstcompile --isymbols=syms.txt --osymbols=syms.txt lemma2verbip.txt  > FINALtransducers/lemma2verbip.fst
fstcompile --isymbols=syms.txt --osymbols=syms.txt lemma2noun.txt  > FINALtransducers/lemma2noun.fst
fstcompile --isymbols=syms.txt --osymbols=syms.txt lemma2adverb.txt  > FINALtransducers/lemma2adverb.fst


fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbif.fst | dot -Tpdf > FINALpdf/lemma2verbif.pdf
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbip.fst | dot -Tpdf > FINALpdf/lemma2verbip.pdf
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbis.fst | dot -Tpdf > FINALpdf/lemma2verbis.pdf
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2noun.fst | dot -Tpdf > FINALpdf/lemma2noun.pdf
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2adverb.fst | dot -Tpdf > FINALpdf/lemma2adverb.pdf



#################  unions para  lemmatoverb.fst  ################ 

fstunion FINALtransducers/lemma2verbif.fst FINALtransducers/lemma2verbis.fst  > union1.fst
fstunion union1.fst FINALtransducers/lemma2verbip.fst > FINALtransducers/lemma2verb.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verb.fst | dot -Tpdf > FINALpdf/lemma2verb.pdf


#################  unions para lemma2word ################ 
 
fstunion FINALtransducers/lemma2verb.fst FINALtransducers/lemma2noun.fst > union3.fst
fstunion union3.fst FINALtransducers/lemma2adverb.fst > FINALtransducers/lemma2word.fst

fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2word.fst | dot -Tpdf > FINALpdf/lemma2word.pdf


#################  invert para word2lemma.fst   ################ 
fstinvert FINALtransducers/lemma2adverb.fst > lemma2adverbR.fst
fstinvert FINALtransducers/lemma2verbif.fst > lemma2verbifR.fst
fstinvert FINALtransducers/lemma2verbis.fst > lemma2verbisR.fst
fstinvert FINALtransducers/lemma2verbip.fst > lemma2verbipR.fst
fstinvert FINALtransducers/lemma2noun.fst > lemma2nounR.fst

fstunion lemma2nounR.fst lemma2adverbR.fst > union1R.fst
fstunion union1R.fst lemma2verbifR.fst > union2R.fst 
fstunion union2R.fst lemma2verbisR.fst > union3R.fst
fstunion union3R.fst lemma2verbipR.fst > FINALtransducers/word2lemma.fst
 
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/word2lemma.fst | dot -Tpdf > FINALpdf/word2lemma.pdf


################ TESTS compila transducers e faz compose para testar ####################################
fstcompile --isymbols=syms.txt --osymbols=syms.txt  Testes/test1.txt | fstarcsort > test1.fst
fstcompile --isymbols=syms.txt --osymbols=syms.txt  Testes/test2.txt | fstarcsort > test2.fst
fstcompile --isymbols=syms.txt --osymbols=syms.txt  Testes/test3.txt | fstarcsort > test3.fst

fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait test1.fst | dot -Tpdf > FINALexamples/test1.pdf
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait test2.fst | dot -Tpdf > FINALexamples/test2.pdf
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait test3.fst | dot -Tpdf > FINALexamples/test3.pdf

# teste lemma2verb 
fstcompose test1.fst FINALtransducers/lemma2verb.fst  > test1_lemma2verb.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait test1_lemma2verb.fst | dot -Tpdf > FINALexamples/test1_lemma2verb.pdf

# teste lemma2word
fstcompose test2.fst FINALtransducers/lemma2word.fst  > test2_lemma2word.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait test2_lemma2word.fst | dot -Tpdf > FINALexamples/test2_lemma2word.pdf

# teste word2lemma
fstcompose test3.fst FINALtransducers/word2lemma.fst  > test3_word2lemma.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait test3_word2lemma.fst | dot -Tpdf > FINALexamples/test3_word2lemma.pdf



