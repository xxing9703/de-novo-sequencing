function [list,mz]=bylist(str)
sz=length(str);
for i=1:sz-1
    st{i,1}=str(1:i);
    [mz(i,1),lb{i,1}]=peptide_mz(st{i,1},'b');
     mz(i,2)=mz(i,1)-18; 
    lb{i,2}=[lb{i,1},'-NH3'];
    st{i,2}=str((i+1):end);
    [mz(i,3),lb{i,3}]=peptide_mz(st{i,2},'y');
    mz(i,4)=mz(i,3)-18;    
    lb{i,4}=[lb{i,3},'-H2O'];
end
list=lb;
