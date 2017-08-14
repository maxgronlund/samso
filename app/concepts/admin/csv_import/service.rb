# namespace to confine service class to Admin:CsvImport::Service
class Admin::CsvImport < ApplicationRecord
  # services for Admin::CsvImport
  class Service
    # usage
    # Admin:CsvImport::Service.new.import(row)
    def import_user(row)
      user_params = {
        id: row[0],
        Abonnr: row[1] == '' ? nil : row[1].to_i,
        Navn: row[2].downcase.titleize,
        Adresse: row[3].downcase.titleize,
        Stednavn: row[4] == '' ? nil : row[4].downcase.titleize,
        Postnr_by: row[5] == '' ? nil : row[5].downcase.titleize,
        Telefon: row[6] == '' ? nil : row[6].downcase,
        Mobil: row[7] == '' ? nil : row[7].downcase,
        Nyhedsbrev: row[8] == '0' ? true : false,
        Email: row[9].downcase,
        Brugernavn: row[10] == '' ? nil : row[10],
        Password: row[11] == '' ? nil : row[11],
        Abon_periode: row[12],
        Oprettet: row[13] == '' ? nil : row[13],
        Aktiv: row[14] == '0',
        UdloebsDato: row[15] == '' ? nil : row[15],
        SessionId: row[16],
        Friabon: row[17] == '0',
        Transact: row[18] == '' ? nil : row[18].to_i,
        Amount: row[19] == '' ? nil : row[15].to_i,
        TransactOpdateret: row[20] == '' ? nil : row[20],
        UpdateFriabon: row[21] == '0',
        UpdateAbon: row[22] == '0',
        BestilAbonavis: row[23] == '0',
        passivAbon: row[24] == '0'
      }
      ap user_params
    end
  end
end
