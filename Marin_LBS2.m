%ME175B/C LBS-2 Fatigue/Failure Analysis
%All equations taken from Shigley's Mechanical Engineering Design
%ISBN 978𢠢7�352928�8
%Material: AISI 1018 Steel
%Unit conventions: Length-inches; Load-ksi
%Written by Daniel Lui

%Given Parameters
d=2; Smin=0; Smax=6; %External given parameters
Sut=64; Sy=54; %Material Property (Table A-20)

%Endurance Limit
if Sut<=200 %endurance limit Se' (6-8)
SePrime=0.5*Sut;
elseif Sut>200
SePrime=100;
end

%Modified Endurance Limit [Marin Equation]

a=2.70; b=-0.265; %Machined or Cold Drawn (Table 6-2)
Ka=a*Sut^b; %Surface Factor Ka (6-19)
de=0.370*d; %effective diameter (6-24)
Kb=0.91*de^-0.157; %Size Factor Kb [given d=2in] (6-20)
Kc=1; %Loading Factor Kc (6-26)
Kd=1; %Temperature Factor Kd (6-28)
za=1.288; ke=0.897; %Reliability 90% (Table 6-5)
Ke=1-0.08*za; %Reliability Factor Ke (6-29)
Kf=1; %Miscellaneous Factor Kf
Ktotal=Ka*Kb*Kc*Kd*Ke*Kf; %Total modifying factors
Se=Ka*Kb*Kc*Kd*Ke*Kf*SePrime; %Marin Equation (6-18)

%Factor of Safety
Sm=(Smax-Smin)/2; %Midrange Component
Sa=(Smax-Smin)/2; %Amplitude Component
nMG=((Sa/Se)+(Sm/Sut))^-1; %Fatigue FoS (Modified Goodman) (Table 6-6)
nGr=0.5*((Sut/Sm)^2)*(Sa/Se)*(-1+sqrt(1+((2*Sm*Se)/(Sut*Sa))^2));
%^Fatigue FoS (Gerber) (Table 6-7)

nAE=sqrt(((Sa/Se)^2+(Sm/Sy)^2)^-1); %Fatigue FoS (ASME elliptic) (Table 6-8)