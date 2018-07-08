function combo=get_mass_combos(aminos, pos, lo, hi, cutoff)
combo=[];
count=0;
wt = aminos{pos,2};
kmax = floor(hi / wt);
npos = pos - 1;
    if npos>0
        for k=0:kmax+1
            mass    = k * wt;
            nlo     = lo - mass;
            nhi     = hi - mass;
            ncutoff = cutoff - mass;
            if nlo <= 0 && nhi >= 0  %found
                combo=[zeros(1,npos),k];
            elseif ncutoff < 0  % out of range
                break
            else  % keep looking
                cc=get_mass_combos(aminos, npos, nlo, nhi, ncutoff);
                for i=1:size(cc,1)
                    combo(count+i,:)=[cc(i,:),k];
                end
                count=count+size(cc,1);
            end
        end
     else      
        kmin = ceil(lo / wt);
        for k=0:kmin
            mass    = k * wt;
            nlo     = lo - mass;
            nhi     = hi - mass;
            ncutoff = cutoff - mass;  
            if nlo <= 0 && nhi >= 0  %found
               combo=k;
            end
           
        end
     end