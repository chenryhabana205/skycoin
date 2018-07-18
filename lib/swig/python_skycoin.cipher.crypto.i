

%extend cipher__Address{
	int __eq__(cipher__Address* a){
		if( $self->Version == a->Version ){
			return memcmp($self->Key, a->Key, sizeof(a->Key)) == 0;
		}
		return 0;
	}
}


%extend cipher_SecKeys {
	cipher_SecKey* getAt(int i){
		if( i < $self->count ){
			return &$self->data[i];
		}
		else
			return NULL;
	}
	
	int setAt(int i, cipher_SecKey* seckey){
		if( i < $self->count){
			memcpy(&self->data[i], seckey, sizeof(*seckey));
			return i;
		} else {
			return -1;
		}
	}
	
	int isEqual(cipher_SecKeys* a){
		return $self->count == a->count && memcmp($self->data, a->data, sizeof(cipher_SecKey) * $self->count) == 0;
	}
	
	void allocate(int n){
		$self->data = malloc(n * sizeof(*($self->data)));
		$self->count = n;
	}
	
	void release(){
		destroy_cipher_SecKeys($self);
	}
}

%inline{
	void destroy_cipher_SecKeys(cipher_SecKeys* p){
		if( p != NULL ){
			if( p->data != NULL ){
				free( p->data );
			}
		}
	}
}

%extend cipher_PubKeys {
	cipher_PubKey* getAt(int i){
		if( i < $self->count ){
			return &$self->data[i];
		}
		else
			return NULL;
	}
	
	int setAt(int i, cipher_PubKey* pubkey){
		if( i < $self->count){
			memcpy(&self->data[i], pubkey, sizeof(*pubkey));
			return i;
		} else {
			return -1;
		}
	}
	
	int isEqual(cipher_PubKeys* a){
		return $self->count == a->count && memcmp($self->data, a->data, sizeof(cipher_PubKey) * $self->count) == 0;
	}
	
	void allocate(int n){
		$self->data = malloc(n * sizeof(*($self->data)));
		$self->count = n;
	}
	
	void release(){
		destroy_cipher_PubKeys($self);
	}
}


%inline{
	void destroy_cipher_PubKeys(cipher_PubKeys* p){
		if( p != NULL ){
			if( p->data != NULL ){
				free( p->data );
			}
		}
	}
}
