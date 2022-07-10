inherited ServiceUsuarios: TServiceUsuarios
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtPesquisanome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object mtPesquisalogin: TWideStringField
      FieldName = 'login'
      Origin = '"login"'
      Size = 30
    end
    object mtPesquisastatus: TSmallintField
      Alignment = taLeftJustify
      FieldName = 'status'
      Origin = 'status'
      OnGetText = mtPesquisastatusGetText
    end
    object mtPesquisatelefone: TWideStringField
      FieldName = 'telefone'
      Origin = 'telefone'
    end
    object mtPesquisasexo: TSmallintField
      Alignment = taLeftJustify
      FieldName = 'sexo'
      Origin = 'sexo'
      OnGetText = mtPesquisasexoGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtCadastronome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 60
    end
    object mtCadastrologin: TWideStringField
      FieldName = 'login'
      Origin = '"login"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 30
    end
    object mtCadastrosenha: TWideStringField
      FieldName = 'senha'
      Origin = 'senha'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 255
    end
    object mtCadastrostatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtCadastrotelefone: TWideStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtCadastrosexo: TSmallintField
      Alignment = taLeftJustify
      FieldName = 'sexo'
      Origin = 'sexo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
end
