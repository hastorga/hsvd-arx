Y = load("DataGrupo1.dat");

memo = 30;
erVec = [];

for z = 1:memo
#Y = [1;2;3;4;5;6;7;8;9;10]; # Data ejeplo easy
n = 10; # niveles de descomposicion
horizonte = 1; #horizonte
h = z; # lag
hrow = 2; # filas hankel
#train = size(Y,1)*0.2; # % de entrenamiento
acum = 0;
#trainData = Y(1:size(Y,1)*train);
B = Y';
#matrix_80_size = int16(size(B,2)*0.8)+1;
#matrix_content = B(1,matrix_80_size:end);

for i = 1:n
#Se obtienen los valores de alta y baja frecuencia que son retornados por la función hsvd 
[B,A] = hsvd(B,hrow);
acum = acum + A; # Suma de las altas frecuencias
endfor

# Se suman los valores de la componente de alta frecuencia a los de baja frecuencia. 
# X debe ser igual al dataset de entrada.
X = B + acum;

# Se obtienen los valores estimados de las frecuencias mediante la AR
lf = ar(B,h, horizonte,train);
arx = [B acum];
hf = ar(arx,h, horizonte,train);

final = hf+lf;
figure(1)
cla()
plot(Y(size(Y,1)-117:end,1))
hold on
plot(final, "r")


#x = [real,final] 





real = Y(size(Y,1)-117:end,1);
e = real-final;
err = mean(real-final).^2;
rmse = err.^0.5;
mae = mean(abs(e));
mape = mean(abs(e./real));
mNSE = 1 - (sum(abs(e))/sum(abs(real.-mean(real)))) ;
GCV(z) = err/(1-(memo/size(Y,1))).^2;
r2 = 1 - (var(e)/var(real));
r2Vec(z) = r2;
rmeVec(z) = rmse;
mnseVec(z) = mNSE;
endfor

figure(2)
cla()
plot(GCV)

figure(3)
cla()
plot(r2Vec)