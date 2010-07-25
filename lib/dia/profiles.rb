module Dia
  module Profiles
    extend(FFI::Library)
    ffi_lib(%w(system))
   
    # The NO_INTERNET profile restricts access to the internet. 
    # @return [String]
    NO_INTERNET                    = attach_variable(:kSBXProfileNoInternet,
                                                     :string).read_string

    # The NO_NETWORKING profile restricts all kinds of networking.
    # @return [String]
    NO_NETWORKING                  = attach_variable(:kSBXProfileNoNetwork,
                                                      :string).read_string

    # The NO_FILESYSTEM_WRITE profile restricts any attempt to write 
    # to the filesystem.
    # @return [String]
    NO_FILESYSTEM_WRITE            = attach_variable(:kSBXProfileNoWrite, 
                                                     :string).read_string

    # The NO_FILESYSTEM_WRITE_EXCEPT_TMP profile restricts any attempt to 
    # write to the filesystem, excluding writes to /var/tmp and the directory
    # specified by _CS_DARWIN_USER_TEMP_DIR. 
    # @return [String]
    NO_FILESYSTEM_WRITE_EXCEPT_TMP = attach_variable(:kSBXProfileNoWriteExceptTemporary,
                                                     :string).read_string

    # The NO_OS_SERVICES is the most restrictive profile, and denies access to all 
    # operating system resources(Internet, Networking, FileSystem writes, etc).
    # @return [String]
    NO_OS_SERVICES                 = attach_variable(:kSBXProfilePureComputation,
                                                     :string).read_string
  end
end
