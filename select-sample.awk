BEGIN {
    # Generate sparse array with random indices, non-repeating
    srand()
    while(1) {
        if(i >= sampleSize) break
        randLineNum = rand() * lineCount
        # awk really needs a `ceil` function
        randLineNum = randLineNum % 1 ? int(randLineNum + 1) : randLineNum
        if(!selectedLines[randLineNum]) {
            selectedLines[randLineNum] = 1
            ++i
        }
    }
}
# Only print lines with the randomly selected numbers
selectedLines[NR]