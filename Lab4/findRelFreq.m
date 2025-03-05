function freq = findRelFreq(audio)
    freq = histcounts(audio, 'Binmethod', 'integers'); 
    freq = freq / sum(freq);
end