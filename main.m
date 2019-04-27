Y = load("DataAR.dat");
#Y = [1,2,3,4,5,6,7,8,9,10];
B = Y';
n = 10;
acum = 0;
h = 1;
matrix_80_size = int16((size(B,2)-h)*0.8)+1;
matrix_content = B(1,matrix_80_size:(size(B,2)-h));
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
size(final)
size(Y(347:end))

# Figura 1
figure(1)
clf('reset')
plot(Y(346:end))
hold on
plot(final, '-','color','r')
set(gcf,'name', 'Name goes here')
legend({'Valor Actual','Valor estimado'},"location",'northwest')
title('(a)')
set(gcf,'name', 'Valor Observado v/s Valor estimado')
xlabel('Time (month)')
ylabel('Y values')

# Figura 2
figure(2)
clf('reset')
plot(Y(347:end),final,'o','color','k')
hold on
set(gcf,'name', 'Name goes here')
legend({'Data Points'},"location",'northwest')
title('(b)')
set(gcf,'name', 'Curva de Dispersion')
xlabel('X')
ylabel('Y')

err = mean((matrix_content'-final).^2)


