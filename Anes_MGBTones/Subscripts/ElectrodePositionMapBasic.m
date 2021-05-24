%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Electrode position matrix for basic multinsensory map
Exp(1).ExpNo=60
Exp(1).Pen=1
Exp(1).Probe='4x8'
Exp(1).LatPos=[repmat(810,1,8),repmat(610,1,8),repmat(410,1,8),repmat(210,1,8)]
Exp(1).VenPos=[repmat(700:-100:0,1,4)]
Exp(1).RosPos=repmat(3.53,1,32)

Exp(2).ExpNo=61
Exp(2).Pen=1
Exp(2).Probe='4x8'
Exp(2).LatPos=[repmat(1210,1,8),repmat(1010,1,8),repmat(810,1,8),repmat(610,1,8)]
Exp(2).VenPos=[repmat(500:-100:-200,1,4)]
Exp(2).RosPos=repmat(3.48,1,32)

Exp(3).ExpNo=62
Exp(3).Pen=1
Exp(3).Probe='8x8'
Exp(3).LatPos=[repmat(1400,1,8),repmat(1200,1,8),repmat(1000,1,8),repmat(800,1,8),repmat(600,1,8),repmat(400,1,8),repmat(200,1,8),repmat(0,1,8)]
Exp(3).VenPos=[repmat(1000:-200:-400,1,8)]
Exp(3).RosPos=repmat(3.4,1,64)


Exp(4).ExpNo=63
Exp(4).Pen=1
Exp(4).Probe='4x8'
Exp(4).LatPos=[repmat(1040,1,8),repmat(840,1,8),repmat(640,1,8),repmat(440,1,8),]
Exp(4).VenPos=[repmat(700:-100:0,1,4)]
Exp(4).RosPos=repmat(3.45,1,32)

Exp(5).ExpNo=65
Exp(5).Pen=1
Exp(5).Probe='8x8'
Exp(5).LatPos=[repmat(1500,1,8),repmat(1300,1,8),repmat(1100,1,8),repmat(900,1,8),repmat(700,1,8),repmat(500,1,8),repmat(300,1,8),repmat(100,1,8)]
Exp(5).VenPos=[repmat(1000:-200:-400,1,8)]
Exp(5).RosPos=repmat(3.3,1,64)

Exp(6).ExpNo=67
Exp(6).Pen=1
Exp(6).Probe='2x32'
Exp(6).LatPos=[repmat(675,1,32),repmat(475,1,32)]
Exp(6).VenPos=[repmat([31:-1:0]*25,1,2)]
Exp(6).RosPos=repmat(3.38,1,64)

Exp(7).ExpNo=68
Exp(7).Pen=1
Exp(7).Probe='2x32'
Exp(7).LatPos=[repmat(700,1,32),repmat(500,1,32)]
Exp(7).VenPos=[repmat([31:-1:0]*25,1,2)]
Exp(7).RosPos=repmat(2.9,1,64)


Exp(8).ExpNo=69
Exp(8).Pen=1
Exp(8).Probe='2x32'
Exp(8).LatPos=[repmat(810,1,32),repmat(610,1,32)]
Exp(8).VenPos=[repmat([31:-1:0]*25,1,2)]
Exp(8).RosPos=repmat(3.6,1,64)


Exp(9).ExpNo=70
Exp(9).Pen=2
Exp(9).Probe='2x32'
Exp(9).LatPos=[repmat(210,1,32),repmat(10,1,32)]
Exp(9).VenPos=[repmat([625:-25:-150],1,2)]
Exp(8).RosPos=repmat(3.5,1,64)


Exp(10).ExpNo=71
Exp(10).Pen=1
Exp(10).Probe='2x32'
Exp(10).LatPos=[repmat(360,1,32),repmat(160,1,32)]
Exp(10).VenPos=[repmat([625:-25:-150],1,2)]
Exp(10).RosPos=repmat(3.55,1,64)


Exp(11).ExpNo=137
Exp(11).Pen=1
Exp(11).Probe='2x32'
Exp(11).LatPos=[repmat(300,1,32),repmat(500,1,32)]
Exp(11).VenPos=[repmat([650:-25:-125],1,2)]
Exp(11).RosPos=repmat(3.55,1,64)

Exp(12).ExpNo=137
Exp(12).Pen=2
Exp(12).Probe='2x32'
Exp(12).LatPos=[repmat(290,1,32),repmat(490,1,32)]
Exp(12).VenPos=[repmat([750:-25:-25],1,2)]
Exp(12).RosPos=repmat(3.55,1,64)

Exp(13).ExpNo=138
Exp(13).Pen=1
Exp(13).Probe='2x32'
Exp(13).LatPos=[repmat(220,1,32),repmat(420,1,32)]
Exp(13).VenPos=[repmat([475:-25:-300],1,2)]
Exp(13).RosPos=repmat(3.55,1,64)

Exp(14).ExpNo=139
Exp(14).Pen=1
Exp(14).Probe='2x32'
Exp(14).LatPos=[repmat(50,1,32),repmat(250,1,32)]
Exp(14).VenPos=[repmat([600:-25:-175],1,2)]
Exp(14).RosPos=repmat(3.55,1,64)

Exp(15).ExpNo=139
Exp(15).Pen=2
Exp(15).Probe='2x32'
Exp(15).LatPos=[repmat(380,1,32),repmat(580,1,32)]
Exp(15).VenPos=[repmat([700:-25:-75],1,2)]
Exp(15).RosPos=repmat(3.55,1,64)

Exp(16).ExpNo=140
Exp(16).Pen=1
Exp(16).Probe='2x32'
Exp(16).LatPos=[repmat(190,1,32),repmat(390,1,32)]
Exp(16).VenPos=[repmat([725:-25:-50],1,2)]
Exp(16).RosPos=repmat(3.55,1,64)

Exp(17).ExpNo=140
Exp(17).Pen=2
Exp(17).Probe='2x32'
Exp(17).LatPos=[repmat(640,1,32),repmat(840,1,32)]
Exp(17).VenPos=[repmat([675:-25:-100],1,2)]
Exp(17).RosPos=repmat(3.55,1,64)

Exp(18).ExpNo=140
Exp(18).Pen=3
Exp(18).Probe='2x32'
Exp(18).LatPos=[repmat(0,1,32),repmat(50,1,32)]
Exp(18).VenPos=[repmat([650:-25:-125],1,2)]
Exp(18).RosPos=repmat(3.55,1,64)
