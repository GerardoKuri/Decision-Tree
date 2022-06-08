%Función que recibe una base de datos que calcula la ganancia de todos
%sus atributos con respecto al atributo de la última columna que se asuma
%es la salida que se desea obtener.
%Devuelve una arreglo de las ganacias calculadas para cada atributo.
function enArr= Entropia(db)
[salidas,a,Us] = unique(db(:,end));
S = sum(accumarray(Us,1));
temp=accumarray(Us,1);
ats=length(temp);
y=0;
for i=1:ats
    x=temp(i)/S;
    y=y+(-(x)*log2(x));
end
len=size(db,2)-1;
for i=1:len
    [salidas,a,Us] = unique(db(:,i));
    temp = accumarray(Us,1);
    ats=length(temp);
    enArr(i)=y;
    for j=1:ats
        I=find(Us==j);
        n_txt=db(I,[i,len+1]);
        [a,b,Us1] = unique(n_txt(:,end));
        temp1 = accumarray(Us1,1);
        ats1=length(temp1);
        S1=sum(temp1);
        y1=0;
        for k=1:ats1
            x1=temp1(k)/S1;
            y1=y1+(-(x1)*log2(x1));
        end        
        enArr(i)=enArr(i)-(temp(j)/S)*y1;
    end
end
end