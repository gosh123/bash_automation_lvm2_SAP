#!/bin/bash 


for SAPSID in TSR TSW TSX TSC TPI TPE TJI TJE DVS
    do


echo "================================================================="
echo "               CREANDO PUNTOS DE MONTAJE PARA $SAPSID"
echo "================================================================="


#CREAR PUNTOS DE MONTAJE $SAPSID:
mkdir -p /usr/sap/${SAPSID}
mkdir -p /sapmnt/${SAPSID}
mkdir -p /sapdb/${SAPSID}
mkdir -p /sapinst${SAPSID}
mkdir -p /tempsw${SAPSID}

echo "================================================================="
echo "               CREANDO VOLÚMENES PARA $SAPSID"
echo "================================================================="

echo "-----------------------------------------------------------------"
echo "               CREANDO /usr/sap/$SAPSID"
echo "-----------------------------------------------------------------"

lvcreate -L 1G -n lv_usr-sap-${SAPSID} vgsys 
mkfs -t ext3 -b 4096 /dev/vgsys/lv_usr-sap-${SAPSID} 
mount /dev/vgsys/lv_usr-sap-${SAPSID} /usr/sap/${SAPSID}

echo "-----------------------------------------------------------------"
echo "               MKDIR PRIMERO"
echo "-----------------------------------------------------------------"


case "$SAPSID" in
    TSR)
        mkdir -p /usr/sap/TSR/DVEBMGS00
	mkdir -p /usr/sap/TSR/ASCS08
	mkdir -p /usr/sap/TSR/SCS09
        ;;
    TSW)
        mkdir -p /usr/sap/TSW/DVEBMGS30
	mkdir -p /usr/sap/TSW/ASCS38
	mkdir -p /usr/sap/TSW/SCS39
        ;;
    TSX)
	mkdir -p /usr/sap/TSX/DVEBMGS60
	mkdir -p /usr/sap/TSX/ASCS68
	mkdir -p /usr/sap/TSX/SCS69
        ;;
    TSC)
	mkdir -p /usr/sap/TSC/DVEBMGS60
	mkdir -p /usr/sap/TSC/ASCS68
	mkdir -p /usr/sap/TSC/SCS69
	;;
    TPI)
	mkdir -p /usr/sap/TPI/JC40
	mkdir -p /usr/sap/TPI/SCS49
	;;
    TPE)
	mkdir -p /usr/sap/TPE/JC50
	mkdir -p /usr/sap/TPE/SCS59
	;;
    TJI)
	mkdir -p /usr/sap/TJI/JC80
	mkdir -p /usr/sap/TJI/SCS87
	;;
    TJE)
	mkdir -p /usr/sap/TJE/JC90
	mkdir -p /usr/sap/TJE/SCS97
	;;
    DVS)
	mkdir -p /usr/sap/DVS/DVEBMGS70
	mkdir -p /usr/sap/DVS/ASCS78
	mkdir -p /usr/sap/DVS/SCS79
	;;
    *)
         echo "ERROR"
         ;;
esac


# En siguiente lvcreate no es necesario especificar pvdisk pq el VG contiene un único pv destinado para todos los LV del VG:

lvcreate -L 10G -n lv_sapmnt-${SAPSID} vgsap${SAPSID} 
mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_sapmnt-${SAPSID}
mount /dev/vgsap${SAPSID}/lv_sapmnt-${SAPSID}	/sapmnt/${SAPSID}


case "$SAPSID" in
    TSR)
	lvcreate -L 10G -n lv_usr-sap-${SAPSID}-DVEBMGS00 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-DVEBMGS00 

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-ASCS08 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-ASCS08	

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-SCS09 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS09	

        mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-DVEBMGS00 /usr/sap/${SAPSID}/DVEBMGS00
	mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-ASCS08 /usr/sap/${SAPSID}/ASCS08
	mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS09 /usr/sap/${SAPSID}/SCS09
        ;;
    TSW)
	lvcreate -L 10G -n lv_usr-sap-${SAPSID}-DVEBMGS30 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-DVEBMGS30 

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-ASCS38 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-ASCS38	

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-SCS39 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS39	

        mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-DVEBMGS30 /usr/sap/${SAPSID}/DVEBMGS30
	mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-ASCS38 /usr/sap/${SAPSID}/ASCS38
	mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS39 /usr/sap/${SAPSID}/SCS39
        ;;
    TSX|TSC)
	lvcreate -L 10G -n lv_usr-sap-${SAPSID}-DVEBMGS60 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-DVEBMGS60 

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-ASCS68 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-ASCS68	

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-SCS69 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS69	

	mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-DVEBMGS60 /usr/sap/${SAPSID}/DVEBMGS60
	mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-ASCS68 /usr/sap/${SAPSID}/ASCS68
	mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS69 /usr/sap/${SAPSID}/SCS69
        ;;
    TPI)
	lvcreate -L 10G -n lv_usr-sap-${SAPSID}-JC40 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-JC40	

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-SCS49 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS49

	mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-JC40 /usr/sap/${SAPSID}/JC40
	mount /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS49 /usr/sap/${SAPSID}/SCS49
	;;
    TPE)
	lvcreate -L 10G -n lv_usr-sap-${SAPSID}-JC50 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-JC50	

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-SCS59 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS59

	mount /dev/vgsapTPE/lv_usr-sap-TPE-JC50 /usr/sap/TPE/JC50
	mount /dev/vgsapTPE/lv_usr-sap-TPE-SCS59 /usr/sap/TPE/SCS59
	;;
    TJI)
	lvcreate -L 10G -n lv_usr-sap-${SAPSID}-JC80 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-JC80	

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-SCS87 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS87

	mount /dev/vgsapTJI/lv_usr-sap-TJI-JC80 /usr/sap/TJI/JC80
	mount /dev/vgsapTJI/lv_usr-sap-TJI-SCS87 /usr/sap/TJI/SCS87
	;;
    TJE)
	lvcreate -L 10G -n lv_usr-sap-${SAPSID}-JC90 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-JC90	

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-SCS97 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS97

	mount /dev/vgsapTJE/lv_usr-sap-TJE-JC90 /usr/sap/TJE/JC90
	mount /dev/vgsapTJE/lv_usr-sap-TJE-SCS97 /usr/sap/TJE/SCS97
	;;
    DVS)
	lvcreate -L 10G -n lv_usr-sap-${SAPSID}-DVEBMGS70 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-DVEBMGS70 

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-ASCS78 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-ASCS78	

	lvcreate -L 500M -n lv_usr-sap-${SAPSID}-SCS79 vgsap${SAPSID} 
	mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_usr-sap-${SAPSID}-SCS79	

        mount /dev/vgsapDVS/lv_usr-sap-DVS-DVEBMGS70 /usr/sap/DVS/DVEBMGS70
	mount /dev/vgsapDVS/lv_usr-sap-DVS-ASCS78 /usr/sap/DVS/ASCS78
	mount /dev/vgsapDVS/lv_usr-sap-DVS-SCS79 /usr/sap/DVS/SCS79
        ;;
    *)
         echo "ERROR"
         ;;
esac

# /sapdb/<SAPSID>
lvcreate -L 1G -n lv_sapdb-${SAPSID} vgsap${SAPSID} 
mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_sapdb-${SAPSID}
mount /dev/vgsap${SAPSID}/lv_sapdb-${SAPSID} /sapdb/${SAPSID}

mkdir -p /sapdb/${SAPSID}/log
mkdir -p /sapdb/${SAPSID}/saparch


echo "-----------------------------------------------------------------"
echo "                  MKDIR SEGUNDO"
echo "-----------------------------------------------------------------"


case "$SAPSID" in
    DVS)
	mkdir -p /sapdb/${SAPSID}/sapdata1
	mkdir -p /sapdb/${SAPSID}/sapdata2
        ;;
    TSR|TSW|TSX|TSC)
	mkdir -p /sapdb/${SAPSID}/sapdata1
	mkdir -p /sapdb/${SAPSID}/sapdata2
	mkdir -p /sapdb/${SAPSID}/sapdata3
	mkdir -p /sapdb/${SAPSID}/sapdata4
        ;;
    TPI|TPE|TJI|TJE)
	mkdir -p /sapdb/${SAPSID}/sapdata1
        ;;
    *)
         echo "ERROR"
         ;;
esac

#SAPINST
lvcreate -L 1500M -n lv_sapinst${SAPSID} vgsap${SAPSID} 
mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_sapinst${SAPSID} 
mount /dev/vgsap${SAPSID}/lv_sapinst${SAPSID} /sapinst${SAPSID}

#TEMPSW
lvcreate -L 10G -n lv_tempsw${SAPSID} vgsap${SAPSID} 
mkfs -t ext3 -b 4096 /dev/vgsap${SAPSID}/lv_tempsw${SAPSID} 
mount /dev/vgsap${SAPSID}/lv_tempsw${SAPSID} /tempsw${SAPSID}


# Pongo en minúsculas el SAPSID:
SAPSIDLOWERCASE="$(echo "$SAPSID" | tr [A-Z] [a-z])"
echo "-------------------------------"
echo "   SAPSIDLOWERCASE = $SAPSIDLOWERCASE"
echo "-------------------------------"


#LOG
LOGLUNTOTALPE=`pvdisplay /dev/sap/log/"$SAPSIDLOWERCASE"_log1 | grep "Total PE" | awk '{FS=" ";print $3}'`
echo "NUMERO DE EXTENSIONES DEL PHYSICAL VOLUME /dev/sap/log/"$SAPSIDLOWERCASE"_log1: $LOGLUNTOTALPE"

lvcreate -l $LOGLUNTOTALPE -n lv_sapdb-${SAPSID}-log vgsapdb${SAPSID} /dev/sap/log/${SAPSIDLOWERCASE}_log1
mkfs -t ext3 -b 4096 /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-log
mount /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-log /sapdb/${SAPSID}/log

#ARCH
ARCHLUNTOTALPE=`pvdisplay /dev/sap/log/"$SAPSIDLOWERCASE"_arch1 | grep "Total PE" | awk '{FS=" ";print $3}'`
echo "NUMERO DE EXTENSIONES DEL PHYSICAL VOLUME /dev/sap/log/"$SAPSIDLOWERCASE"_arch1: $ARCHLUNTOTALPE"

lvcreate  -l $ARCHLUNTOTALPE -n lv_sapdb-${SAPSID}-saparch vgsapdb${SAPSID} /dev/sap/log/${SAPSIDLOWERCASE}_arch1
mkfs -t ext3 -b 4096 /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-saparch
mount /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-saparch /sapdb/${SAPSID}/saparch

#DATA1: SE EJECUTA EN TODAS LAS SAPSID
DATA11LUNTOTALPE=`pvdisplay /dev/sap/data/"$SAPSIDLOWERCASE"_data11 | grep "Total PE" | awk '{FS=" ";print $3}'`
echo "NUMERO DE EXTENSIONES DEL PHYSICAL VOLUME /dev/sap/data/"$SAPSIDLOWERCASE"_data11: $DATA11LUNTOTALPE"

lvcreate -l $DATA11LUNTOTALPE -n lv_sapdb-${SAPSID}-sapdata1 vgsapdb${SAPSID} /dev/sap/data/${SAPSIDLOWERCASE}_data11
mkfs -t ext3 -b 4096 /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-sapdata1	
mount /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-sapdata1	/sapdb/${SAPSID}/sapdata1


#DATA2: 
case "$SAPSID" in
    TSR|TSW|TSX|TSC|DVS)
	DATA21LUNTOTALPE=`pvdisplay /dev/sap/data/"$SAPSIDLOWERCASE"_data21 | grep "Total PE" | awk '{FS=" ";print $3}'`
	echo "NUMERO DE EXTENSIONES DEL PHYSICAL VOLUME /dev/sap/data/"$SAPSIDLOWERCASE"_data21: $DATA21LUNTOTALPE"
	
	lvcreate -l $DATA21LUNTOTALPE -n lv_sapdb-${SAPSID}-sapdata2 vgsapdb${SAPSID} /dev/sap/data/${SAPSIDLOWERCASE}_data21
	mkfs -t ext3 -b 4096 /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-sapdata2
	mount /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-sapdata2 /sapdb/${SAPSID}/sapdata2
	;;
    *)
         echo "NO NECESARIO CREAR SAPDATA2 Y SAPDATA3 PARA SAPSID $SAPSID"
         ;;
esac

case "$SAPSID" in
    TSR|TSW|TSX|TSC)
	#DATA3
	DATA31LUNTOTALPE=`pvdisplay /dev/sap/data/"$SAPSIDLOWERCASE"_data31 | grep "Total PE" | awk '{FS=" ";print $3}'`
	echo "NUMERO DE EXTENSIONES DEL PHYSICAL VOLUME /dev/sap/data/"$SAPSIDLOWERCASE"_data31: $DATA11LUNTOTALPE"

	lvcreate -l $DATA31LUNTOTALPE -n lv_sapdb-${SAPSID}-sapdata3 vgsapdb${SAPSID} /dev/sap/data/${SAPSIDLOWERCASE}_data31
	mkfs -t ext3 -b 4096 /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-sapdata3
	mount /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-sapdata3 /sapdb/${SAPSID}/sapdata3

	#DATA4
	DATA41LUNTOTALPE=`pvdisplay /dev/sap/data/"$SAPSIDLOWERCASE"_data41 | grep "Total PE" | awk '{FS=" ";print $3}'`
	echo "NUMERO DE EXTENSIONES DEL PHYSICAL VOLUME /dev/sap/data/"$SAPSIDLOWERCASE"_data41: $DATA11LUNTOTALPE"

	lvcreate -l $DATA41LUNTOTALPE -n lv_sapdb-${SAPSID}-sapdata4 vgsapdb${SAPSID} /dev/sap/data/${SAPSIDLOWERCASE}_data41
	mkfs -t ext3 -b 4096 /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-sapdata4
	mount /dev/vgsapdb${SAPSID}/lv_sapdb-${SAPSID}-sapdata4 /sapdb/${SAPSID}/sapdata4
        ;;
    *)
         echo "NO NECESARIO CREAR SAPDATA3 Y SAPDATA4 PARA SAPSID $SAPSID"
         ;;
esac

done