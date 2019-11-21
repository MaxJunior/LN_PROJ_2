#!env python3
import argparse
import csv
import re
import codecs

if __name__ == '__main__':
    PARSER = argparse.ArgumentParser(description="Converts a word into an FST")
    PARSER.add_argument("-s", dest="symbols", default=None, help="file containing the symbols")
    PARSER.add_argument('word', help='a word')
    args = PARSER.parse_args()
     
    file = codecs.open("test2.txt", "w", "utf-8")
    if not args.symbols:
        # processes character by character
        for i,c in enumerate(args.word):
            line = str(i) +"\t" + str(i+1) + "\t" + str(c) + "\t" + str(c) +"\n"
            file.write(line)
            print("%d %d %s %s" % (i, i+1, c, c) )
        print(i+1)
        file.write(str(i+1))
        file.close()
    else:
        with open(args.symbols) as f:
            symbols = [ row.split()[0] for row in f if row.split()[0] != "eps" ]
            symbols.sort(key = lambda s: len(s), reverse=True)
            tmp=re.sub("\+","\+","|".join(symbols))
            #print(tmp.encode("utf-8"))
            exp = re.compile(tmp)

        word = args.word
        m = exp.match(word)
        i=0
       
        
        while ( len(word) > 0 ) and ( m is not None ):
            line = str(i) + "\t"+ str(i+1) + "\t"+ m.group() +"\t" + m.group() +"\n"
            print("%d %d %s %s" % (i, i+1, m.group(), m.group()) )
            file.write(line)
            word = word[m.end():]
            m = exp.match(word)
            i += 1
        
        if len(word) > 0:
            print("unknown symbols in expression: ", word)
        else:
            file.write(str(i))
            file.close()
            print(i)
