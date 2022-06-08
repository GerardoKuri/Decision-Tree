%Función que recibe una base de datos de 4 atributos que construye un
%árbol de decisión de 4 niveles máximo según la salida que se asume que es la última columna.
%La estructura de salida corresponde al árbol simplificado con las
%características de cada nodo.
function arbol = fourLevelDecTree(DB)
ganancia=Entropia(DB);
[M,I]=max(ganancia);
arbol.nivel(1).nodo(1).ramas=size(unique(DB(:,I)),1);
arbol.nivel(1).nodo(1).ganancia=M;
arbol.nivel(1).nodo(1).solucion=[];
if M==0
    arbol.nivel(1).nodo(1).solucion=DB(1,end);
    arbol.nivel(1).nodo(1).ramas=0;
    arbol.nivel(1).nodo(1).categorias=[];
end
for i=1:arbol.nivel(1).nodo(1).ramas
    U=unique(DB(:,I));
    L=strcmp(DB,U(i,1));
    T=DB;
    T(:,I)=[];
    arbol.nivel(1).nodo(1).db(i).table=T(L(:,I),:);
    if i==1
        arbol.nivel(1).nodo(1).categorias=U;
    end
end
cont=0;
cont1=0;
cont2=0;
for i=1:arbol.nivel(1).nodo(1).ramas
    ganancia=Entropy(arbol.nivel(1).nodo(1).db(1,i).table);
    [M,I]=max(ganancia);
    arbol.nivel(2).nodo(i).ramas=size(unique(arbol.nivel(1).nodo(1).db(1,i).table(:,I)),1);
    U=unique(arbol.nivel(1).nodo(1).db(1,i).table(:,I));
    arbol.nivel(2).nodo(i).categorias=U;
    arbol.nivel(2).nodo(i).ganancia=M;
    arbol.nivel(2).nodo(i).solucion=[];
    arbol.nivel(2).nodo(i).padre=1;
    if M==0
        arbol.nivel(2).nodo(i).solucion=arbol.nivel(1).nodo(1).db(1,i).table(1,end);
        arbol.nivel(2).nodo(i).ramas=0;
        arbol.nivel(2).nodo(i).categorias=[];
    end
    for j=1:arbol.nivel(2).nodo(i).ramas
        L=strcmp(arbol.nivel(1).nodo(1).db(1,i).table,arbol.nivel(2).nodo(i).categorias(j));
        T=arbol.nivel(1).nodo(1).db(1,i).table;
        T(:,I)=[];
        arbol.nivel(2).nodo(i).db(1,j).table=T(L(:,I),:);
    end
    for j=1:arbol.nivel(2).nodo(i).ramas
        cont=cont+1;
        ganancia=Entropia(arbol.nivel(2).nodo(i).db(1,j).table);
        [M,I]=max(ganancia);
        arbol.nivel(3).nodo(cont).ramas=size(unique(arbol.nivel(2).nodo(i).db(1,j).table(:,I)),1);
        U=unique(arbol.nivel(2).nodo(i).db(1,j).table(:,I));
        arbol.nivel(3).nodo(cont).categorias=U;
        arbol.nivel(3).nodo(cont).ganancia=M;
        arbol.nivel(3).nodo(cont).solucion=[];
        arbol.nivel(3).nodo(cont).padre=i;
        if M==0
            arbol.nivel(3).nodo(cont).solucion=arbol.nivel(2).nodo(i).db(1,j).table(1,end);
            arbol.nivel(3).nodo(cont).ramas=0;
            arbol.nivel(3).nodo(cont).categorias=[];
        end
        for k=1:arbol.nivel(3).nodo(cont).ramas
            L=strcmp(arbol.nivel(2).nodo(i).db(1,j).table,arbol.nivel(3).nodo(cont).categorias(k));
            T=arbol.nivel(2).nodo(i).db(1,j).table;
            T(:,I)=[];
            arbol.nivel(3).nodo(cont).db(1,k).table=T(L(:,I),:);
        end
        for k=1:arbol.nivel(3).nodo(cont).ramas
            cont1=cont1+1;
            ganancia=Entropia(arbol.nivel(3).nodo(cont).db(1,k).table);
            [M,I]=max(ganancia);
            arbol.nivel(4).nodo(cont1).ramas=size(unique(arbol.nivel(3).nodo(cont).db(1,k).table(:,I)),1);
            U=unique(arbol.nivel(3).nodo(cont).db(1,k).table(:,I));
            arbol.nivel(4).nodo(cont1).categorias=U;
            arbol.nivel(4).nodo(cont1).ganancia=M;
            arbol.nivel(4).nodo(cont1).solucion=[];
            arbol.nivel(4).nodo(cont1).padre=j;
            if M==0
                arbol.nivel(4).nodo(cont1).solucion=arbol.nivel(3).nodo(cont).db(1,k).table(1,end);
                arbol.nivel(4).nodo(cont1).ramas=0;
                arbol.nivel(4).nodo(cont1).categorias=[];
            end
            for m=1:arbol.nivel(4).nodo(cont1).ramas
                L=strcmp(arbol.nivel(3).nodo(cont).db(1,k).table,arbol.nivel(4).nodo(cont1).categorias(m));
                T=arbol.nivel(3).nodo(cont).db(1,k).table;
                T(:,I)=[];
                arbol.nivel(4).nodo(cont1).db(1,m).table=T(L(:,I),:);
            end
            for m=1:arbol.nivel(4).nodo(cont1).ramas
                cont2=cont2+1;
                 arbol.nivel(5).nodo(cont2).solucion=arbol.nivel(4).nodo(cont1).db(1,m).table(1,end);
            end
        end
    end
end
end