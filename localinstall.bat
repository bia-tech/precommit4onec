@ECHO OFF
del "*.ospx"
opm build . -mf ./packagedef -out .
opm install -f precommit4onec-1.0.6.ospx