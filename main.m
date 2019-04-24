Y = load("DataAR.dat");
#Y = [1,2,3,4,5,6,7,8,9,10];
B = Y';
n = 1;
acum = 0;
h = 3;

matrix_80_size = int16(size(B,2)*0.8)+1;
matrix_content = B(1,matrix_80_size:end)

for i = 1:n
#Se obtienen los valores de alta y baja frecuencia que son retornados por la función hsvd 
[B,A] = hsvd(B);
acum = acum + A; # Suma de las altas frecuencias
endfor

# Se suman los valores de la componente de alta frecuencia a los de baja frecuencia. 
# X debe ser igual al dataset de entrada.
X = B + acum;
mean((X-Y).^2);

# Se obtienen los valores estimados de las frecuencias mediante la AR
l = ar(B,h);
h = ar(acum,h);
final = l+h;
figure(1)
plot(Y)
figure(2)
plot(final)
err = mean((matrix_content'-final).^2)


